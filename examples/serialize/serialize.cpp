
#include <parser/Instance.h>
#include <multiagent/ConcurrencyDomain.h>
#include <typeinfo>

using namespace parser::pddl;

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

void replaceConcurrencyPredicates( parser::multiagent::ConcurrencyDomain * d, Domain * cd, Condition * cond ) {
	And * a = dynamic_cast< And * >( cond );
	for ( unsigned i = 0; a && i < a->conds.size(); ++i) {
		replaceConcurrencyPredicates( d, cd, a->conds[i] );
	}

	Exists * e = dynamic_cast< Exists * >( cond );
	if ( e ) replaceConcurrencyPredicates( d, cd, e->cond );

	Forall * f = dynamic_cast< Forall * >( cond );
	if ( f ) replaceConcurrencyPredicates( d, cd, f->cond );

	Ground * g = dynamic_cast< Ground * >( cond );
	if ( g ) {
		if ( d->cpreds.index( g->name ) != -1 ) {
			std::string newName = "ACTIVE-" + g->name;
			g->name = newName;
			g->lifted = cd->preds.get( newName );
		}
	}

	Not * n = dynamic_cast< Not * >( cond );
	if ( n ) replaceConcurrencyPredicates( d, cd, n->cond );

	Or * o = dynamic_cast< Or * >( cond );
	if ( o ) {
		replaceConcurrencyPredicates( d, cd, o->first );
		replaceConcurrencyPredicates( d, cd, o->second );
	}

	When * w = dynamic_cast< When * >( cond );
	if ( w ) {
		replaceConcurrencyPredicates( d, cd, w->pars );
		replaceConcurrencyPredicates( d, cd, w->cond );
	}
}

void addSelectAction( parser::multiagent::ConcurrencyDomain * d, Domain * cd, int actionId ) {
	Action * originalAction = d->actions[actionId];

	std::string actionName = "SELECT-" + originalAction->name;

	Action * newAction = cd->createAction( actionName, d->typeList(originalAction) );
	unsigned numActionParams = newAction->params.size();

	cd->addPre( 0, actionName, "SELECTING" );
	cd->addPre( 0, actionName, "FREE-AGENT", IntVec( 1, 0 ) );
	cd->addPre( 1, actionName, "REQ-NEG-" + originalAction->name, incvec( 0, numActionParams ) );

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

	replaceConcurrencyPredicates( d, cd, newAction->eff );

	cd->addEff( 1, actionName, "BUSY-AGENT", IntVec( 1, 0 ) );
	cd->addEff( 0, actionName, "DONE-AGENT", IntVec( 1, 0 ) );
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
		addSelectAction( d, cd, i );
		addDoAction( d, cd, i );
		addEndAction( d, cd, i );
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
