
#include <parser/Instance.h>
#include <multiagent/ConcurrencyDomain.h>
#include <typeinfo>

using namespace parser::pddl;

struct ConditionClassification
{
	unsigned numActionParams;
	unsigned lastParamId;

	std::map< unsigned, Condition * > paramToCond; // parameter number to condition that declares it (forall, exists)

	std::vector< Condition * > posConcConds; // conditions that include positive concurrency
	std::vector< Condition * > negConcConds; // conditions that include negative concurrency
	std::vector< Condition * > normalConds; // conditions that do not include concurrency constraints

	ConditionClassification( unsigned numParams)
		: numActionParams( numParams ), lastParamId( numParams - 1 ) {
	}
};

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
	cd->createPredicate( "FREE" );
	cd->createPredicate( "SELECTING" );
	cd->createPredicate( "APPLYING" );
	cd->createPredicate( "RESETTING" );

	cd->createPredicate( "FREE-AGENT", StringVec( 1, "AGENT" ) );
	cd->createPredicate( "BUSY-AGENT", StringVec( 1, "AGENT" ) );
	cd->createPredicate( "DONE-AGENT", StringVec( 1, "AGENT" ) );
}

void addPredicates( parser::multiagent::ConcurrencyDomain * d, Domain * cd ) {
	addStatePredicates( cd );
	addOriginalPredicates( d, cd );
}

void replaceConcurrencyPredicatesWithActive( parser::multiagent::ConcurrencyDomain * d, Domain * cd, Condition * cond ) {
	And * a = dynamic_cast< And * >( cond );
	for ( unsigned i = 0; a && i < a->conds.size(); ++i) {
		replaceConcurrencyPredicatesWithActive( d, cd, a->conds[i] );
	}

	Exists * e = dynamic_cast< Exists * >( cond );
	if ( e ) replaceConcurrencyPredicatesWithActive( d, cd, e->cond );

	Forall * f = dynamic_cast< Forall * >( cond );
	if ( f ) replaceConcurrencyPredicatesWithActive( d, cd, f->cond );

	Ground * g = dynamic_cast< Ground * >( cond );
	if ( g ) {
		if ( d->cpreds.index( g->name ) != -1 ) {
			std::string newName = "ACTIVE-" + g->name;
			g->name = newName;
			g->lifted = cd->preds.get( newName );
		}
	}

	Not * n = dynamic_cast< Not * >( cond );
	if ( n ) replaceConcurrencyPredicatesWithActive( d, cd, n->cond );

	Or * o = dynamic_cast< Or * >( cond );
	if ( o ) {
		replaceConcurrencyPredicatesWithActive( d, cd, o->first );
		replaceConcurrencyPredicatesWithActive( d, cd, o->second );
	}

	When * w = dynamic_cast< When * >( cond );
	if ( w ) {
		replaceConcurrencyPredicatesWithActive( d, cd, w->pars );
		replaceConcurrencyPredicatesWithActive( d, cd, w->cond );
	}
}

void classifyGround( parser::multiagent::ConcurrencyDomain * d, Domain * cd, Ground * g, int groundType, ConditionClassification & condClassif ) {
	std::vector< Condition * > nestedConditions;
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

	if ( nestedConditions.empty() ) {
		switch ( groundType ) {
			case -2:
			{
				Ground * cg = dynamic_cast< Ground * >( g->copy( *cd ) );
				condClassif.normalConds.push_back( new Not( cg ) );
				break;
			}
			case -1:
				condClassif.negConcConds.push_back( g );
				break;
			case 1:
				condClassif.posConcConds.push_back( g );
				break;
			case 2:
				condClassif.normalConds.push_back( g->copy( *cd ) );
				break;
		}

		for ( unsigned i = 0; i < condClassif.normalConds.size(); ++i ){
			std::cout << condClassif.normalConds[i] << "\n";
		}

		std::cout << "to main and" << std::endl;
	}
	else { // necesita modificaciones... (en algunos casos se podrian clasificar predicados vecinos colateralmente, como los not (= ) en exists)
		std::cout << "not to main and" << std::endl;
	}
}

void getClassifiedConditions( parser::multiagent::ConcurrencyDomain * d, Domain * cd, Condition * cond, ConditionClassification & condClassif ) {
	And * a = dynamic_cast< And * >( cond );
	for ( unsigned i = 0; a && i < a->conds.size(); ++i) {
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

void addSelectAction( parser::multiagent::ConcurrencyDomain * d, Domain * cd, int actionId, ConditionClassification & condClassif ) {
	Action * originalAction = d->actions[actionId];

	std::string actionName = "SELECT-" + originalAction->name;

	Action * newAction = cd->createAction( actionName, d->typeList(originalAction) );
	unsigned numActionParams = newAction->params.size();

	// preconditions
	cd->addPre( 0, actionName, "SELECTING" );
	cd->addPre( 0, actionName, "FREE-AGENT", IntVec( 1, 0 ) );
	cd->addPre( 1, actionName, "REQ-NEG-" + originalAction->name, incvec( 0, numActionParams ) );

	for ( unsigned i = 0; i < condClassif.normalConds.size(); ++i ) {
		And * a = dynamic_cast< And * >( newAction->pre );
		a->add( condClassif.normalConds[i] );
	}

	// effects
	cd->addEff( 1, actionName, "FREE-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "BUSY-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "ACTIVE-" + originalAction->name, incvec( 0, numActionParams ) );
}

void addDoAction( parser::multiagent::ConcurrencyDomain * d, Domain * cd, int actionId ) {
	Action * originalAction = d->actions[actionId];

	std::string actionName = "DO-" + originalAction->name;

	Action * newAction = cd->createAction( actionName, d->typeList(originalAction) );
	unsigned numActionParams = newAction->params.size();

	cd->addPre( 0, actionName, "APPLYING" );
	cd->addPre( 0, actionName, "BUSY-AGENT", IntVec( 1, 0 ) );
	cd->addPre( 0, actionName, "ACTIVE-" + originalAction->name, incvec( 0, numActionParams ) );

	newAction->eff = originalAction->eff->copy( *cd );
	cd->addEff( 1, actionName, "BUSY-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "DONE-AGENT", IntVec( 1, 0 ) );
	replaceConcurrencyPredicatesWithActive( d, cd, newAction->eff );
}

void addEndAction( parser::multiagent::ConcurrencyDomain * d, Domain * cd, int actionId ) {
	Action * originalAction = d->actions[actionId];

	std::string actionName = "END-" + originalAction->name;

	Action * newAction = cd->createAction( actionName, d->typeList(originalAction) );
	unsigned numActionParams = newAction->params.size();

	cd->addPre( 0, actionName, "RESETTING" );
	cd->addPre( 0, actionName, "DONE-AGENT", IntVec( 1, 0 ) );
	cd->addPre( 0, actionName, "ACTIVE-" + originalAction->name, incvec( 0, numActionParams ) );

	cd->addEff( 1, actionName, "DONE-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "FREE-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 1, actionName, "ACTIVE-" + originalAction->name, incvec( 0, numActionParams ) );
}

void addStartAction( Domain * cd ) {
	std::string actionName = "START";
	cd->createAction(actionName);
	cd->addPre( 0, actionName, "FREE" );
	cd->addEff( 1, actionName, "FREE" );
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
	cd->addEff( 0, actionName, "FREE" );

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

void addActions( parser::multiagent::ConcurrencyDomain * d, Domain * cd ) {
	addStateChangeActions( cd );

	// select, do and end actions for each original action
	for ( unsigned i = 0; i < d->actions.size(); ++i ) {
		ConditionClassification condClassif( d->actions[i]->params.size() );
		getClassifiedConditions( d, cd, d->actions[i]->pre, condClassif );

		addSelectAction( d, cd, i, condClassif );
		break;
		//addDoAction( d, cd, i );
		//addEndAction( d, cd, i );
	}
}

Domain * createClassicalDomain( parser::multiagent::ConcurrencyDomain * d ) {
	Domain * cd = new Domain;
	cd->name = d->name;
	cd->condeffects = cd->cons = cd->typed = true;

	// add types and constants
	cd->setTypes( d->copyTypes() );

	addPredicates( d, cd );
	addActions( d, cd );

	return cd;
}

int main( int argc, char *argv[] ) {
	if ( argc < 3 ) {
		std::cout << "Usage: ./serialize.bin <domain.pddl> <task.pddl>\n";
		exit(1);
	}

	// load multiagent domain and instance
	parser::multiagent::ConcurrencyDomain * d = new parser::multiagent::ConcurrencyDomain( argv[1] );
	Instance * ins = new Instance( *d, argv[2] );

	// create classical/single-agent domain
	Domain * cd = createClassicalDomain( d );

	std::cout << *cd;

	delete d;
	delete ins;
	delete cd;

	return 0;
}
