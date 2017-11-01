
#include <parser/Instance.h>
#include <multiagent/ConcurrencyDomain.h>
#include <typeinfo>
#include <fstream>

using namespace parser::pddl;

void addTypes( parser::multiagent::ConcurrencyDomain * d, Domain * cd, bool useAgentOrder, int maxJointActionSize ) {
	cd->setTypes( d->copyTypes() );

	if ( useAgentOrder ) {
		cd->createType( "AGENT-ORDER-COUNT" );
	}

	if ( maxJointActionSize > 0 ) {
		cd->createType( "ATOMIC-ACTION-COUNT" );
	}
}

void addAgentType( parser::multiagent::ConcurrencyDomain * d ) {
	// in some domains, the AGENT type is not specified, so we add the type
	// manually
	// all the types in :agent have their supertype set to AGENT (if they do not
	// already have it)
	if ( d->types.index( "AGENT" ) < 0 ) {
		// get types of agents (first parameter of actions)
		std::set< Type * > agentTypes;
		for ( unsigned i = 0; i < d->actions.size(); ++i ) {
			Action * action = d->actions[i];
			StringVec actionParams = d->typeList( action );
			if ( actionParams.size() > 0 ) {
				std::string firstParamStr = actionParams[0];
				Type * firstParamType = d->getType( firstParamStr );
				agentTypes.insert( firstParamType );
			}
		}

		// get supertypes only (as subtypes are already covered by supertypes)
		std::set< Type * > agentSupertypes;
		for ( auto it = agentTypes.begin(); it != agentTypes.end(); ++it ) {
			Type * currentType = *it;
			Type * itType = currentType;
			bool isSupertype = true;
			while ( itType ) {
				Type * parentType = itType->supertype;
				bool inAgentSet = agentTypes.find( parentType ) != agentTypes.end();
				if ( inAgentSet ) {
					isSupertype = false;
					break;
				}
				itType = parentType;
			}
			if ( isSupertype ) {
				agentSupertypes.insert( currentType );
			}
			else {
				agentSupertypes.erase( currentType );
			}
		}

		// check if all supertypes share a common parent (it is necessary, since types
		// can only have one parent)
		bool allHaveSameParent = true;
		Type * parentType = (*(agentSupertypes.begin()))->supertype;

		for ( auto it = agentSupertypes.begin(); it != agentSupertypes.end(); ++it ) {
			if ( (*it)->supertype != parentType ) {
				allHaveSameParent = false;
				break;
			}
		}

		// if all have same parent, add AGENT type between supertype and members
		// of agentSupertypes
		if ( allHaveSameParent ) {
			d->createType( "AGENT", parentType->name );
			Type * agentType = d->getType( "AGENT" );

			for ( auto it = agentSupertypes.begin(); it != agentSupertypes.end(); ++it ) {
				auto itFind = std::find( parentType->subtypes.begin(), parentType->subtypes.end(), *it );
				parentType->subtypes.erase( itFind );
				agentType->insertSubtype( *it );
			}
		}
	}
}

void addFunctions( parser::multiagent::ConcurrencyDomain * d, Domain * cd ) {
	for ( unsigned i = 0; i < d->funcs.size(); ++i ) {
		cd->createFunction( d->funcs[i]->name, d->funcs[i]->returnType, d->typeList( d->funcs[i] ) );
	}
}

struct ConditionClassification
{
	unsigned numActionParams;
	unsigned lastParamId;

	std::map< unsigned, Condition * > paramToCond; // parameter number to condition that declares it (forall, exists)

	CondVec posConcConds; // conditions that include positive concurrency
	CondVec negConcConds; // conditions that include negative concurrency
	CondVec normalConds; // conditions that do not include concurrency constraints

	CondVec checkedConds; // conditions that have been checked and cannot be checked again (i.e. exists)

	ConditionClassification( unsigned numParams)
		: numActionParams( numParams ), lastParamId( numParams - 1 ) {
	}

	~ConditionClassification() {
		// the concurrency conditions contained in posConcConds and negConcConds
		// vectors are just referenced here
		// when creating the select, do and end actions, these conditions are COPIED
		// thus, they must be cleared here
		for ( unsigned i = 0; i < posConcConds.size(); ++i ) {
			delete posConcConds[i];
		}

		for ( unsigned i = 0; i < negConcConds.size(); ++i ) {
			delete negConcConds[i];
		}
	}
};

void addNoopAction( parser::multiagent::ConcurrencyDomain * d ) {
	std::string actionName = "NOOP";
	Action * a = new parser::multiagent::ConcurrentAction( actionName );
	a->params.push_back( d->types.index( "AGENT" ) );
	a->pre = new And;
	a->eff = new And;
	d->actions.insert( a );
	d->addConcurrencyPredicateFromAction( a );
}

void addOriginalPredicates( parser::multiagent::ConcurrencyDomain * d, Domain * cd ) {
	for ( unsigned i = 0; i < d->preds.size(); ++i ) {
		if ( d->cpreds.index( d->preds[i]->name ) == -1 )
		{
			cd->createPredicate( d->preds[i]->name, d->typeList( d->preds[i] ) );
		}
		else
		{
			cd->createPredicate( "ACTIVE-" + d->preds[i]->name, d->typeList( d->preds[i] ) );
			cd->createPredicate( "REQ-NEG-" + d->preds[i]->name, d->typeList( d->preds[i] ) );
		}
	}
}

void addStatePredicates( Domain * cd ) {
	cd->createPredicate( "FREE-BLOCK" );
	cd->createPredicate( "SELECTING" );
	cd->createPredicate( "APPLYING" );
	cd->createPredicate( "RESETTING" );

	cd->createPredicate( "FREE-AGENT", StringVec( 1, "AGENT" ) );
	cd->createPredicate( "BUSY-AGENT", StringVec( 1, "AGENT" ) );
	cd->createPredicate( "DONE-AGENT", StringVec( 1, "AGENT" ) );
}

void addAgentOrderPredicates( Domain * cd ) {
	StringVec sv = StringVec( 1, "AGENT" );
	sv.push_back( "AGENT-ORDER-COUNT" );
	cd->createPredicate( "AGENT-ORDER", sv );

	cd->createPredicate( "PREV-AGENT-ORDER-COUNT", StringVec( 2, "AGENT-ORDER-COUNT" ) );
	cd->createPredicate( "NEXT-AGENT-ORDER-COUNT", StringVec( 2, "AGENT-ORDER-COUNT" ) );
	cd->createPredicate( "CURRENT-AGENT-ORDER-COUNT", StringVec( 1, "AGENT-ORDER-COUNT" ) );
}

void addJointActionSizePredicates( Domain * cd, int maxJointActionSize ) {
	cd->createPredicate( "PREV-ATOMIC-ACTION-COUNT", StringVec( 2, "ATOMIC-ACTION-COUNT" ) );
	cd->createPredicate( "NEXT-ATOMIC-ACTION-COUNT", StringVec( 2, "ATOMIC-ACTION-COUNT" ) );
	cd->createPredicate( "CURRENT-ATOMIC-ACTION-COUNT", StringVec( 1, "ATOMIC-ACTION-COUNT" ) );
}

void addPredicates( parser::multiagent::ConcurrencyDomain * d, Domain * cd, bool useAgentOrder, int maxJointActionSize ) {
	addStatePredicates( cd );
	addOriginalPredicates( d, cd );

	if ( useAgentOrder ) {
		addAgentOrderPredicates( cd );
	}

	if ( maxJointActionSize > 0 ) {
		addJointActionSizePredicates( cd, maxJointActionSize );
	}
}

Condition * replaceConcurrencyPredicates( parser::multiagent::ConcurrencyDomain * d, Domain * cd, Condition * cond, std::string& replacementPrefix, bool turnNegative ) {
	And * a = dynamic_cast< And * >( cond );
	if ( a ) {
		for ( unsigned i = 0; i < a->conds.size(); ++i ) {
			a->conds[i] = replaceConcurrencyPredicates( d, cd, a->conds[i], replacementPrefix, turnNegative );
		}
		return a;
	}

	Exists * e = dynamic_cast< Exists * >( cond );
	if ( e ) {
		e->cond = replaceConcurrencyPredicates( d, cd, e->cond, replacementPrefix, turnNegative );
		return e;
	}

	Forall * f = dynamic_cast< Forall * >( cond );
	if ( f ) {
		f->cond = replaceConcurrencyPredicates( d, cd, f->cond, replacementPrefix, turnNegative );
		return f;
	}

	Increase * i = dynamic_cast< Increase * >( cond );
	if ( i ) {
		return i;
	}

	Not * n = dynamic_cast< Not * >( cond );
	if ( n ) {
		n->cond = dynamic_cast< Ground * >( replaceConcurrencyPredicates( d, cd, n->cond, replacementPrefix, turnNegative ) );
		return n;
	}

	Ground * g = dynamic_cast< Ground * >( cond );
	if ( g ) {
		if ( d->cpreds.index( g->name ) != -1 ) {
			std::string newName = replacementPrefix + g->name;
			g->name = newName;
			g->lifted = cd->preds.get( newName );
			if ( turnNegative ) {
				return new Not( g );
			}
		}
		return g;
	}

	Or * o = dynamic_cast< Or * >( cond );
	if ( o ) {
		o->first = replaceConcurrencyPredicates( d, cd, o->first, replacementPrefix, turnNegative );
		o->second = replaceConcurrencyPredicates( d, cd, o->second, replacementPrefix, turnNegative );
		return o;
	}

	When * w = dynamic_cast< When * >( cond );
	if ( w ) {
		w->pars = replaceConcurrencyPredicates( d, cd, w->pars, replacementPrefix, turnNegative );
		w->cond = replaceConcurrencyPredicates( d, cd, w->cond, replacementPrefix, turnNegative );
		return w;
	}

	return nullptr;
}

int getDominantGroundTypeForCondition( parser::multiagent::ConcurrencyDomain * d, Condition * cond ) {
	And * a = dynamic_cast< And * >( cond );
	if ( a ) {
		int finalRes = 0;
		for ( unsigned i = 0; i < a->conds.size(); ++i ) {
			finalRes = getDominantGroundTypeForCondition( d, a->conds[i] );
			if ( finalRes == -1 || finalRes == 1 ) {
				break;
			}
		}
		return finalRes;
	}

	Exists * e = dynamic_cast< Exists * >( cond );
	if ( e ) {
		return getDominantGroundTypeForCondition( d, e->cond );
	}

	Forall * f = dynamic_cast< Forall * >( cond );
	if ( f ) {
		return getDominantGroundTypeForCondition( d, f->cond );
	}

	Not * n = dynamic_cast< Not * >( cond );
	if ( n ) {
		Ground * gn = dynamic_cast< Ground * >( n->cond );

		if ( d->cpreds.index( gn->name ) != -1 ) {
			return -1;
		}
		else {
			return -2;
		}
	}

	Ground * g = dynamic_cast< Ground * >( cond );
	if ( g ) {
		if ( d->cpreds.index( g->name ) != -1 ) {
			return 1;
		}
		else {
			return 2;
		}
	}

	return 0;
}

std::pair< Condition *, int > createFullNestedCondition( parser::multiagent::ConcurrencyDomain * d, Domain * cd, Ground * g, int groundType, ConditionClassification & condClassif, CondVec& nestedConditions ) {
	Condition * finalCond = nullptr;
	int finalGroundType = groundType;
	And * lastAnd = nullptr;

	for ( unsigned i = 0; i < nestedConditions.size(); ++i ) {
		Condition * newCond = nullptr;
		And * currentAnd = nullptr;

		Forall * f = dynamic_cast< Forall * >( nestedConditions[i] );
		if ( f ) {
			Forall * nf = new Forall;
			nf->params = IntVec( f->params );
			nf->cond = new And;

			newCond = nf;
			currentAnd = dynamic_cast< And * >( nf->cond );
		}

		Exists * e = dynamic_cast< Exists * >( nestedConditions[i] );
		if ( e ) {
			Exists * ne = nullptr;

			if ( dynamic_cast< And * >( e->cond ) ) {
				ne = dynamic_cast< Exists * >( e->copy( *d ) );
			}
			else {
				ne = new Exists;
				ne->params = IntVec( e->params );

				And * newAnd = new And;
				newAnd->add( e->cond->copy( *d ) );

				ne->cond = newAnd;
			}

			condClassif.checkedConds.push_back( nestedConditions[i] );

			// the ground type can be changed if there is a concurrency predicate
			// inside the exists
			if ( groundType != -1 && groundType != 1 ) {
				finalGroundType = getDominantGroundTypeForCondition( d, nestedConditions[i] );
			}

			newCond = ne;
			currentAnd = nullptr; // do not nest anything more inside this structure
		}

		if ( newCond ) {
			if ( !finalCond ) {
				finalCond = newCond;
			}

			if ( lastAnd ) {
				lastAnd->add( newCond );
			}

			lastAnd = currentAnd;

			if ( !lastAnd ) {
				break;
			}
		}
	}

	if ( lastAnd ) { // just non null in the case of forall
		switch ( finalGroundType ) {
			case -2:
			{
				Ground * cg = dynamic_cast< Ground * >( g->copy( *cd ) );
				lastAnd->add( new Not( cg ) );
				break;
			}
			case -1:
			case 1:
				lastAnd->add( g->copy( *d ) );
				break;
			case 2:
				lastAnd->add( g->copy( *cd ) );
				break;
		}
	}

	return std::make_pair( finalCond, finalGroundType );
}

bool isGroundClassified( Ground * g, ConditionClassification & condClassif ) {
	for ( auto it = g->params.begin(); it != g->params.end(); ++it ) {
		unsigned paramId = *it;
		if ( paramId >= condClassif.numActionParams ) { // non-action parameter (introduced by forall or exists)
			Condition * cond = condClassif.paramToCond[paramId];
			if ( std::find( condClassif.checkedConds.begin(), condClassif.checkedConds.end(), cond) != condClassif.checkedConds.end() ) {
				return true;
			}
		}
	}

	return false;
}

void getNestedConditionsForGround( CondVec& nestedConditions, Ground * g, ConditionClassification & condClassif ) {
	Condition * lastNestedCondition = nullptr;

	std::set< int > sortedGroundParams( g->params.begin(), g->params.end() ); // sort to respect nested order

	for ( auto it = sortedGroundParams.begin(); it != sortedGroundParams.end(); ++it ) {
		unsigned paramId = *it;
		if ( paramId >= condClassif.numActionParams ) { // non-action parameter (introduced by forall or exists)
			Condition * cond = condClassif.paramToCond[ paramId ];
			if ( cond != lastNestedCondition ) {
				nestedConditions.push_back( cond );
				lastNestedCondition = cond;
			}
		}
	}
}

void classifyGround( parser::multiagent::ConcurrencyDomain * d, Domain * cd, Ground * g, int groundType, ConditionClassification & condClassif ) {
	if ( !isGroundClassified( g, condClassif ) ) {
		CondVec nestedConditions;
		getNestedConditionsForGround( nestedConditions, g, condClassif );

		if ( nestedConditions.empty() ) {
			switch ( groundType ) {
				case -2:
				{
					Ground * cg = dynamic_cast< Ground * >( g->copy( *cd ) );
					condClassif.normalConds.push_back( new Not( cg ) );
					break;
				}
				case -1:
					condClassif.negConcConds.push_back( g->copy( *d ) );
					break;
				case 1:
					condClassif.posConcConds.push_back( g->copy( *d ) );
					break;
				case 2:
					condClassif.normalConds.push_back( g->copy( *cd ) );
					break;
			}
		}
		else {
			std::pair< Condition *, int > result = createFullNestedCondition( d, cd, g, groundType, condClassif, nestedConditions );
			Condition * nestedCondition = result.first;
			groundType = result.second;

			switch ( groundType ) {
				case -2:
				case 2:
					condClassif.normalConds.push_back( nestedCondition );
					break;
				case -1:
					condClassif.negConcConds.push_back( nestedCondition );
					break;
				case 1:
					condClassif.posConcConds.push_back( nestedCondition );
					break;
			}
		}
	}
}

void getClassifiedConditions( parser::multiagent::ConcurrencyDomain * d, Domain * cd, Condition * cond, ConditionClassification & condClassif ) {
	And * a = dynamic_cast< And * >( cond );
	for ( unsigned i = 0; a && i < a->conds.size(); ++i ) {
		getClassifiedConditions( d, cd, a->conds[i], condClassif );
	}

	Exists * e = dynamic_cast< Exists * >( cond );
	if ( e ) {
		for ( unsigned i = 0; i < e->params.size(); ++i ) {
			++condClassif.lastParamId;
			condClassif.paramToCond[ condClassif.lastParamId ] = e;
		}

		getClassifiedConditions( d, cd, e->cond, condClassif );

		condClassif.lastParamId -= e->params.size();
	}

	Forall * f = dynamic_cast< Forall * >( cond );
	if ( f ) {
		for ( unsigned i = 0; i < f->params.size(); ++i ) {
			++condClassif.lastParamId;
			condClassif.paramToCond[ condClassif.lastParamId ] = f;
		}

		getClassifiedConditions( d, cd, f->cond, condClassif );

		condClassif.lastParamId -= f->params.size();
	}

	Ground * g = dynamic_cast< Ground * >( cond );
	if ( g ) {
		int category = d->cpreds.index( g->name ) != -1 ? 1 : 2;
		classifyGround( d, cd, g, category, condClassif );
	}

	Not * n = dynamic_cast< Not * >( cond );
	if ( n ) {
		Ground * ng = dynamic_cast< Ground * >( n->cond );
		if ( ng ) {
			int category = d->cpreds.index( ng->name ) != -1 ? -1 : -2;
			classifyGround( d, cd, ng, category, condClassif );
		}
		else {
			getClassifiedConditions( d, cd, n->cond, condClassif );
		}
	}
}

void addSelectAction( parser::multiagent::ConcurrencyDomain * d, Domain * cd, int actionId, bool useAgentOrder, int maxJointActionSize, ConditionClassification & condClassif ) {
	Action * originalAction = d->actions[actionId];

	std::string actionName = "SELECT-" + originalAction->name;

	Action * newAction = cd->createAction( actionName, d->typeList( originalAction ) );
	unsigned numActionParams = newAction->params.size();

	// preconditions
	cd->addPre( 0, actionName, "SELECTING" );
	cd->addPre( 0, actionName, "FREE-AGENT", IntVec( 1, 0 ) );
	cd->addPre( 1, actionName, "REQ-NEG-" + originalAction->name, incvec( 0, numActionParams ) );

	And * actionPre = dynamic_cast< And * >( newAction->pre );
	std::string replacementPrefix = "ACTIVE-";

	for ( unsigned i = 0; i < condClassif.normalConds.size(); ++i ) {
		actionPre->add( condClassif.normalConds[i] );
	}

	for ( unsigned i = 0; i < condClassif.negConcConds.size(); ++i ) {
		Condition * replacedCondition = replaceConcurrencyPredicates( d, cd, condClassif.negConcConds[i]->copy( *d ), replacementPrefix, true );
		actionPre->add( replacedCondition );
	}

	// effects
	cd->addEff( 1, actionName, "FREE-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "BUSY-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "ACTIVE-" + originalAction->name, incvec( 0, numActionParams ) );

	And * actionEff = dynamic_cast< And * >( newAction->eff );
	replacementPrefix = "REQ-NEG-";

	for ( unsigned i = 0; i < condClassif.negConcConds.size(); ++i ) {
		Condition * replacedCondition = replaceConcurrencyPredicates( d, cd, condClassif.negConcConds[i]->copy( *d ), replacementPrefix, false );
		actionEff->add( replacedCondition );
	}

	if ( useAgentOrder ) {
		newAction->addParams( cd->convertTypes( StringVec( 2, "AGENT-ORDER-COUNT" ) ) );

		IntVec orderParams = IntVec( 1, 0 ); // agent parameter
		orderParams.push_back( numActionParams ); // num of parameter corresponding to AGENT-ORDER-COUNT (just added in previous line)
		cd->addPre( 0, actionName, "AGENT-ORDER", orderParams );
		cd->addPre( 0, actionName, "NEXT-AGENT-ORDER-COUNT", incvec( numActionParams, numActionParams + 2 ) );
		cd->addPre( 0, actionName, "CURRENT-AGENT-ORDER-COUNT", IntVec( 1, numActionParams ) );

		cd->addEff( 1, actionName, "CURRENT-AGENT-ORDER-COUNT", IntVec( 1, numActionParams ) );
		cd->addEff( 0, actionName, "CURRENT-AGENT-ORDER-COUNT", IntVec( 1, numActionParams + 1 ) );

		numActionParams += 2;
	}

	if ( maxJointActionSize > 0 ) {
		newAction->addParams( cd->convertTypes( StringVec( 2, "ATOMIC-ACTION-COUNT" ) ) );

		cd->addPre( 0, actionName, "NEXT-ATOMIC-ACTION-COUNT", incvec( numActionParams, numActionParams + 2 ) );
		cd->addPre( 0, actionName, "CURRENT-ATOMIC-ACTION-COUNT", IntVec( 1, numActionParams ) );

		cd->addEff( 1, actionName, "CURRENT-ATOMIC-ACTION-COUNT", IntVec( 1, numActionParams ) );
		cd->addEff( 0, actionName, "CURRENT-ATOMIC-ACTION-COUNT", IntVec( 1, numActionParams + 1 ) );
	}
}

void addDoAction( parser::multiagent::ConcurrencyDomain * d, Domain * cd, int actionId, ConditionClassification & condClassif ) {
	Action * originalAction = d->actions[actionId];

	std::string actionName = "DO-" + originalAction->name;

	Action * newAction = cd->createAction( actionName, d->typeList( originalAction ) );
	unsigned numActionParams = newAction->params.size();

	// preconditions
	cd->addPre( 0, actionName, "APPLYING" );
	cd->addPre( 0, actionName, "BUSY-AGENT", IntVec( 1, 0 ) );
	cd->addPre( 0, actionName, "ACTIVE-" + originalAction->name, incvec( 0, numActionParams ) );

	And * newActionPre = dynamic_cast< And * >( newAction->pre );
	std::string replacementPrefix = "ACTIVE-";

	for ( unsigned i = 0; i < condClassif.posConcConds.size(); ++i ) {
		Condition * replacedCondition = replaceConcurrencyPredicates( d, cd, condClassif.posConcConds[i]->copy( *d ), replacementPrefix, false );
		newActionPre->add( replacedCondition );
	}

	// effects
	cd->addEff( 1, actionName, "BUSY-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "DONE-AGENT", IntVec( 1, 0 ) );

	And * newActionEff = dynamic_cast< And * >( newAction->eff );

	if ( And * originalActionEff = dynamic_cast< And * >( originalAction->eff ) ) {
		for ( unsigned i = 0; i < originalActionEff->conds.size(); ++i ) {
			newActionEff->add( originalActionEff->conds[i]->copy( *d ) );
		}
	}
	else if ( originalAction->eff != nullptr ){
		newActionEff->add( originalAction->eff->copy( *d ) );
	}

	newAction->eff = replaceConcurrencyPredicates( d, cd, newAction->eff, replacementPrefix, false );
}

void addEndAction( parser::multiagent::ConcurrencyDomain * d, Domain * cd, int actionId, bool useAgentOrder, int maxJointActionSize, ConditionClassification & condClassif ) {
	Action * originalAction = d->actions[actionId];

	std::string actionName = "END-" + originalAction->name;

	Action * newAction = cd->createAction( actionName, d->typeList( originalAction ) );
	unsigned numActionParams = newAction->params.size();

	// preconditions
	cd->addPre( 0, actionName, "RESETTING" );
	cd->addPre( 0, actionName, "DONE-AGENT", IntVec( 1, 0 ) );
	cd->addPre( 0, actionName, "ACTIVE-" + originalAction->name, incvec( 0, numActionParams ) );

	// effects
	cd->addEff( 1, actionName, "DONE-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "FREE-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 1, actionName, "ACTIVE-" + originalAction->name, incvec( 0, numActionParams ) );

	And * actionEff = dynamic_cast< And * >( newAction->eff );
	std::string replacementPrefix = "REQ-NEG-";

	for ( unsigned i = 0; i < condClassif.negConcConds.size(); ++i ) {
		Condition * replacedCondition = replaceConcurrencyPredicates( d, cd, condClassif.negConcConds[i]->copy( *d ), replacementPrefix, true );
		actionEff->add( replacedCondition );
	}

	if ( useAgentOrder ) {
		newAction->addParams( cd->convertTypes( StringVec( 2, "AGENT-ORDER-COUNT" ) ) );

		cd->addPre( 0, actionName, "PREV-AGENT-ORDER-COUNT", incvec( numActionParams, numActionParams + 2 ) );
		cd->addPre( 0, actionName, "CURRENT-AGENT-ORDER-COUNT", IntVec( 1, numActionParams ) );

		cd->addEff( 1, actionName, "CURRENT-AGENT-ORDER-COUNT", IntVec( 1, numActionParams ) );
		cd->addEff( 0, actionName, "CURRENT-AGENT-ORDER-COUNT", IntVec( 1, numActionParams + 1 ) );

		numActionParams += 2;
	}

	if ( maxJointActionSize > 0 ) {
		newAction->addParams( cd->convertTypes( StringVec( 2, "ATOMIC-ACTION-COUNT" ) ) );

		cd->addPre( 0, actionName, "PREV-ATOMIC-ACTION-COUNT", incvec( numActionParams, numActionParams + 2 ) );
		cd->addPre( 0, actionName, "CURRENT-ATOMIC-ACTION-COUNT", IntVec( 1, numActionParams ) );

		cd->addEff( 1, actionName, "CURRENT-ATOMIC-ACTION-COUNT", IntVec( 1, numActionParams ) );
		cd->addEff( 0, actionName, "CURRENT-ATOMIC-ACTION-COUNT", IntVec( 1, numActionParams + 1 ) );
	}
}

void addStartAction( Domain * cd ) {
	std::string actionName = "START";
	cd->createAction(actionName);
	cd->addPre( 0, actionName, "FREE-BLOCK" );
	cd->addEff( 1, actionName, "FREE-BLOCK" );
	cd->addEff( 0, actionName, "SELECTING" );
}

void addApplyAction( Domain * cd ) {
	std::string actionName = "APPLY";
	cd->createAction(actionName);
	cd->addPre( 0, actionName, "SELECTING" );
	cd->addEff( 1, actionName, "SELECTING" );
	cd->addEff( 0, actionName, "APPLYING" );
}

void addResetAction( Domain * cd ) {
	std::string actionName = "RESET";
	cd->createAction(actionName);
	cd->addPre( 0, actionName, "APPLYING" );
	cd->addEff( 1, actionName, "APPLYING" );
	cd->addEff( 0, actionName, "RESETTING" );
}

void addFinishAction( Domain * cd ) {
	std::string actionName = "FINISH";
	Action * action = cd->createAction(actionName);
	cd->addPre( 0, actionName, "RESETTING" );
	cd->addEff( 1, actionName, "RESETTING" );
	cd->addEff( 0, actionName, "FREE-BLOCK" );

	Forall * f = new Forall;
	f->params = cd->convertTypes( StringVec( 1, "AGENT" ) );
	f->cond = new Ground( cd->preds.get( "FREE-AGENT" ), incvec( 0, f->params.size() ) );

	And * a = dynamic_cast< And * >( action->pre );
	a->add( f );
}

void addStateChangeActions( Domain * cd ) {
	addStartAction( cd );
	addApplyAction( cd );
	addResetAction( cd );
	addFinishAction( cd );
}

void addActions( parser::multiagent::ConcurrencyDomain * d, Domain * cd, bool useAgentOrder, int maxJointActionSize ) {
	addStateChangeActions( cd );

	// select, do and end actions for each original action
	for ( unsigned i = 0; i < d->actions.size(); ++i ) {
		ConditionClassification condClassif( d->actions[i]->params.size() );
		getClassifiedConditions( d, cd, d->actions[i]->pre, condClassif );

		addSelectAction( d, cd, i, useAgentOrder, maxJointActionSize, condClassif );
		addDoAction( d, cd, i, condClassif );
		addEndAction( d, cd, i, useAgentOrder, maxJointActionSize, condClassif );
	}
}

Domain * createClassicalDomain( parser::multiagent::ConcurrencyDomain * d, bool useAgentOrder, int maxJointActionSize ) {
	Domain * cd = new Domain;
	cd->name = d->name;
	cd->condeffects = cd->cons = cd->typed = cd->neg = cd->equality = cd->universal = true;
	cd->costs = d->costs;

	addTypes( d, cd, useAgentOrder, maxJointActionSize );
	addFunctions( d, cd );
	addPredicates( d, cd, useAgentOrder, maxJointActionSize );
	addActions( d, cd, useAgentOrder, maxJointActionSize );

	return cd;
}

Instance * createTransformedInstance( Domain * cd, Instance * ins, bool useAgentOrder, int maxJointActionSize ) {
	Instance * cins = new Instance( *cd );
	cins->name = ins->name;
	cins->metric = ins->metric;

	// create initial state
	Type * agentType = cd->types.get( "AGENT" );
	cins->addInit( "FREE-BLOCK" );
	for ( unsigned i = 0; i < agentType->noObjects(); ++i ) {
		cins->addInit( "FREE-AGENT", StringVec( 1, agentType->object(i).first ) );
	}

	for ( unsigned i = 0; i < ins->init.size(); ++i ) {
		if ( cd->preds.index( ins->init[i]->name ) >= 0 ) {
			cins->addInit( ins->init[i]->name, cd->objectList( ins->init[i] ) );
		}
		else if ( GroundFunc<double> * gfd = dynamic_cast< GroundFunc<double> * >( ins->init[i] ) ) {
			cins->addInit( gfd->name, gfd->value, cd->objectList( gfd ) );
		}
		else if ( GroundFunc<int> * gfi = dynamic_cast< GroundFunc<int> * >( ins->init[i] ) ) {
			cins->addInit( gfi->name, gfi->value, cd->objectList( gfi ) );
		}
	}

	// create goal state
	cins->addGoal( "FREE-BLOCK" );
	for ( unsigned i = 0; i < ins->goal.size(); ++i ) {
		cins->addGoal( ins->goal[i]->name, cd->objectList( ins->goal[i] ) );
	}

	if ( useAgentOrder ) {
		for ( unsigned i = 1; i <= agentType->noObjects() + 1; ++i ) {
			std::stringstream ss;
			ss << "AGENT-COUNT" << i;
			cins->addObject( ss.str(), "AGENT-ORDER-COUNT" );
		}

		if ( agentType->noObjects() > 0 ) {
			cins->addInit( "CURRENT-AGENT-ORDER-COUNT", StringVec( 1, "AGENT-COUNT1" ) );
		}

		for ( unsigned i = 1; i <= agentType->noObjects(); ++i ) {
			std::stringstream ss;
			ss << "AGENT-COUNT" << i;

			StringVec sv( 1, agentType->object(i - 1).first );
			sv.push_back( ss.str() );
			cins->addInit( "AGENT-ORDER", sv );

			std::stringstream ss2;
			ss2 << "AGENT-COUNT" << i + 1;

			StringVec sv2( 1, ss.str() );
			sv2.push_back( ss2.str() );
			cins->addInit( "NEXT-AGENT-ORDER-COUNT", sv2 );

			StringVec sv3( 1, ss2.str() );
			sv3.push_back( ss.str() );
			cins->addInit( "PREV-AGENT-ORDER-COUNT", sv3 );
		}
	}

	if ( maxJointActionSize > 0 ) {
		for ( int i = 0; i <= maxJointActionSize; ++i ) {
			std::stringstream ss;
			ss << "ATOMIC-COUNT" << i;
			cins->addObject( ss.str(), "ATOMIC-ACTION-COUNT" );
		}

		cins->addInit( "CURRENT-ATOMIC-ACTION-COUNT", StringVec( 1, "ATOMIC-COUNT0" ) );

		for ( int i = 0; i < maxJointActionSize; ++i ) {
			std::stringstream ss, ss2;
			ss << "ATOMIC-COUNT" << i;
			ss2 << "ATOMIC-COUNT" << i + 1;

			StringVec sv1( 1, ss.str() );
			sv1.push_back( ss2.str() );
			cins->addInit( "NEXT-ATOMIC-ACTION-COUNT", sv1 );

			StringVec sv2( 1, ss2.str() );
			sv2.push_back( ss.str() );
			cins->addInit( "PREV-ATOMIC-ACTION-COUNT", sv2 );
		}
	}

	return cins;
}

int main( int argc, char *argv[] ) {
	if ( argc < 5 ) {
		std::cout << "Usage: ./serialize.bin <domain.pddl> <task.pddl> <use-agent-order> <max-joint-actions>\n";
		exit(1);
	}

	bool useAgentOrder = atoi(argv[3]) != 0;
	int maxJointActionSize = std::stoi(argv[4]); // no maximum number of actions --> -1

	// load multiagent domain and instance
	parser::multiagent::ConcurrencyDomain * d = new parser::multiagent::ConcurrencyDomain( argv[1] );
	Instance * ins = new Instance( *d, argv[2] );

	addAgentType( d );

	// add no-op action that will be used in the transformation
	if ( useAgentOrder ) {
		addNoopAction( d );
	}

	// create classical/single-agent domain
	Domain * cd = createClassicalDomain( d, useAgentOrder, maxJointActionSize );
	std::cout << *cd;

	Instance * ci = createTransformedInstance( cd, ins, useAgentOrder, maxJointActionSize );
	std::cerr << *ci;

	delete ins;
	delete d;
	delete ci;
	delete cd;

	return 0;
}
