
#include <parser/Instance.h>
#include <multiagent/ConcurrencyDomain.h>

using namespace parser::pddl;

void addPredicates( Domain * d, Domain * cd ) {
	parser::multiagent::ConcurrencyDomain * dp = dynamic_cast<parser::multiagent::ConcurrencyDomain*>( d );

	for ( unsigned i = 0; i < dp->preds.size(); ++i ) {
		if ( dp->cpreds.index( dp->preds[i]->name ) == -1 )
		{
			cd->createPredicate( d->preds[i]->name, d->typeList( d->preds[i] ) );
		}
		else
		{
			cd->createPredicate( "POS-" + d->preds[i]->name, d->typeList( d->preds[i] ) );
			cd->createPredicate( "NEG-" + d->preds[i]->name, d->typeList( d->preds[i] ) );
			cd->createPredicate( "REQ-" + d->preds[i]->name, d->typeList( d->preds[i] ) );
		}
	}
}

void addActions( Domain * d, Domain * cd ) {
	/*
	for (unsigned i = 0; i < d->actions.size(); ++i ) {
		std::string nameStart = "START-" + d->actions[i]->name;
		std::string nameDo = "DO-" + d->actions[i]->name;
		std::string nameEnd = "END-" + d->actions[i]->name;
		cd->createAction( nameStart );
		cd->createAction( nameDo );
		cd->createAction( nameEnd );
		cd->addEff( 0, nameEnd, );
	}*/
}

Domain * createClassicalDomain( Domain * d ) {
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
	Domain * d = new parser::multiagent::ConcurrencyDomain( argv[1] );
	Instance * ins = new Instance( *d, argv[2] );

	// create classical/single-agent domain
	Domain * cd = createClassicalDomain( d );

	cd->print(std::cout);

	delete d;
	delete ins;
	delete cd;

	return 0;
}
