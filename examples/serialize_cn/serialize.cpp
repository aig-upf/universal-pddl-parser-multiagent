// To check for memory leaks:
// valgrind --leak-check=yes examples/serialize ../multiagent/codmap/domains/tablemover/tablemover.pddl ../multiagent/codmap/domains/tablemover/table1_1.pddl

#include <parser/Instance.h>
#include <multiagent/MultiagentDomain.h>

using namespace parser::pddl;

parser::multiagent::MultiagentDomain * d;
Instance * ins;
std::set< unsigned > prob;

typedef std::map< unsigned, std::vector< int > > VecMap;

bool deletes( const Ground * ground, const parser::multiagent::NetworkNode * n, unsigned k ) {
	for ( unsigned i = 0; i < n->templates.size(); ++i )
		if ( i != k ) {
			Action * a = d->actions[d->actions.index( n->templates[i]->name )];
			CondVec pres = a->precons();
			for ( unsigned j = 0; j < pres.size(); ++j ) {
				Ground * g = dynamic_cast< Ground * >( pres[j] );
				if ( g && g->name == ground->name &&
				     std::find( g->params.begin(), g->params.end(), 0 ) == g->params.end() )
					return true;
			}
		}
	return false;
}

// returns true if at least one instance of "POS-" or "NEG-" added
bool addEff( Domain * cd, Action * a, Condition * c ) {
	Not * n = dynamic_cast< Not * >( c );
	Ground * g = dynamic_cast< Ground * >( c );
	if ( n && prob.find( d->preds.index( n->cond->name ) ) != prob.end() ) {
		cd->addEff( 0, a->name, "NEG-" + n->cond->name, n->cond->params );
		return 1;
	}
	if ( g && prob.find( d->preds.index( g->name ) ) != prob.end() ) {
		cd->addEff( 0, a->name, "POS-" + g->name, g->params );
		return 1;
	}
	
	if ( n )
		cd->addEff( 1, a->name, n->cond->name, n->cond->params );
	else if ( g )
		cd->addEff( 0, a->name, g->name, g->params );
	else if ( c ) {
		if ( !a->eff ) a->eff = new And;
		And * aa = dynamic_cast< And * >( a->eff );
		aa->add( c->copy( *cd ) );
	}

	return 0;
}

int main( int argc, char *argv[] ) {
	if ( argc < 3 ) {
		std::cout << "Usage: ./transform <domain.pddl> <task.pddl>\n";
		exit( 1 );
	}

	// Read multiagent domain and instance with associated concurrency network

	d = new parser::multiagent::MultiagentDomain( argv[1] );
	ins = new Instance( *d, argv[2] );

	// Identify problematic fluents (preconditions deleted by agents)
	// For now, disregard edges

	for ( unsigned i = 0; i < d->nodes.size(); ++i ) {
		for ( unsigned j = 0; d->nodes[i]->upper > 1 && j < d->nodes[i]->templates.size(); ++j ) {
			Action * a = d->actions[d->actions.index( d->nodes[i]->templates[j]->name )];
			GroundVec dels = a->deleteEffects();

			for ( unsigned k = 0; k < dels.size(); ++k ) {
				if ( std::find( dels[k]->params.begin(), dels[k]->params.end(), 0 ) == dels[k]->params.end() &&
				     deletes( dels[k], d->nodes[i], j ) ) {
					prob.insert( d->preds.index( dels[k]->name ) );
				}
			}
		}
	}

	VecMap ccs;
	for ( unsigned i = 0; i < d->mf.size(); ++i )
		ccs[d->mf[i]].push_back( i );

	// Create classical domain
	Domain * cd = new Domain;
	cd->name = d->name;
	cd->condeffects = cd->cons = cd->typed = true;

	// Add types
	cd->setTypes( d->copyTypes() );
	cd->createType( "AGENT-COUNT" );

	// Add constants
	cd->createConstant( "ACOUNT-0", "AGENT-COUNT" );

	// Add predicates
	for ( unsigned i = 0; i < d->preds.size(); ++i ) {
		cd->createPredicate( d->preds[i]->name, d->typeList( d->preds[i] ) );
		if ( prob.find( i ) != prob.end() ) {
			cd->createPredicate( "POS-" + d->preds[i]->name );
			cd->createPredicate( "NEG-" + d->preds[i]->name );
		}
	}
	cd->createPredicate( "AFREE" );
	cd->createPredicate( "ATEMP" );
	cd->createPredicate( "TAKEN", StringVec( 1, "AGENT" ) );
	cd->createPredicate( "CONSEC", StringVec( 2, "AGENT-COUNT" ) );
	for ( unsigned i = 0; i < d->nodes.size(); ++i ) {
		VecMap::iterator j = ccs.find( d->mf[i] );
		if ( j->second.size() > 1 || d->nodes[i]->upper > 1 ) {
			cd->createPredicate( "ACTIVE-" + d->nodes[i]->name, d->typeList( d->nodes[i] ) );
			cd->createPredicate( "COUNT-" + d->nodes[i]->name, StringVec( 1, "AGENT-COUNT" ) );
			cd->createPredicate( "SAT-" + d->nodes[i]->name, StringVec( 1, "AGENT-COUNT" ) );
		}
		if ( j->second.size() > 1 ) {
			cd->createPredicate( "USED-" + d->nodes[i]->name );
			cd->createPredicate( "DONE-" + d->nodes[i]->name );
			cd->createPredicate( "SKIPPED-" + d->nodes[i]->name );
		}
	}

	// Add actions
	for ( VecMap::iterator i = ccs.begin(); i != ccs.end(); ++i ) {
		std::set< unsigned > visited;
		for ( unsigned j = 0; j < i->second.size(); ++j ) {
			int x = i->second[j];
			visited.insert( x );

			if ( i->second.size() > 1 || d->nodes[x]->upper > 1 ) {
				std::string name = "START-" + d->nodes[x]->name;
				unsigned size = d->nodes[x]->params.size();
				cd->createAction( name, d->typeList( d->nodes[x] ) );

				if ( j > 0 ) {
					for ( unsigned k = 0; k < d->edges.size(); ++k )
						if ( d->edges[k].second == x ) {
							std::set< unsigned >::iterator it = visited.find( d->edges[k].first );
							if ( it != visited.end() )
								cd->addPre( 0, name, "DONE-" + d->nodes[d->edges[k].first]->name );
						}
					cd->addOrPre( name, "DONE-" + d->nodes[i->second[j - 1]]->name, "SKIPPED-" + d->nodes[i->second[j - 1]]->name );
					cd->addPre( 0, name, "ACTIVE-" + d->nodes[i->second[j - 1]]->name, incvec( 0, size ) );
					cd->addPre( 1, name, "USED-" + d->nodes[x]->name );
					
				}
				else cd->addPre( 0, name, "AFREE" );

				if ( j < 1 ) cd->addEff( 1, name, "AFREE" );
				cd->addEff( 0, name, "ACTIVE-" + d->nodes[x]->name, incvec( 0, size ) );
				cd->addEff( 0, name, "COUNT-" + d->nodes[x]->name, IntVec( 1, -1 ) );
				if ( i->second.size() > 1 )
					cd->addEff( 0, name, "USED-" + d->nodes[x]->name );
			}

			if ( i->second.size() > 1 ) {
				std::string name = "SKIP-" + d->nodes[x]->name;
				unsigned size = d->nodes[x]->params.size();
				cd->createAction( name, d->typeList( d->nodes[x] ) );

				if ( j > 0 ) {
					for ( unsigned k = 0; k < d->edges.size(); ++k )
						if ( d->edges[k].first == i->second[j] ) {
							std::set< unsigned >::iterator it = visited.find( d->edges[k].second );
							if ( it != visited.end() )
								cd->addPre( 0, name, "SKIPPED-" + d->nodes[d->edges[k].second]->name );
						}
					cd->addOrPre( name, "DONE-" + d->nodes[i->second[j - 1]]->name, "SKIPPED-" + d->nodes[i->second[j - 1]]->name );
					cd->addPre( 0, name, "ACTIVE-" + d->nodes[i->second[j - 1]]->name, incvec( 0, size ) );
					cd->addPre( 1, name, "USED-" + d->nodes[x]->name );
				}
				else cd->addPre( 0, name, "AFREE" );

				if ( !j ) cd->addEff( 1, name, "AFREE" );
				cd->addEff( 0, name, "ACTIVE-" + d->nodes[x]->name, incvec( 0, size ) );
				cd->addEff( 0, name, "SKIPPED-" + d->nodes[x]->name );
				cd->addEff( 0, name, "USED-" + d->nodes[x]->name );
			}

			bool concurEffs = 0;
			for ( unsigned k = 0; k < d->nodes[x]->templates.size(); ++k ) {
				int action = d->actions.index( d->nodes[x]->templates[k]->name );
				std::string name = "DO-" + d->actions[action]->name;
				unsigned size = d->actions[action]->params.size();
				Action * doit = cd->createAction( name, d->typeList( d->actions[action] ) );

				// copy old preconditions
				And * oldpre = dynamic_cast< And * >( d->actions[action]->pre );
				if ( oldpre ) doit->pre = new And( oldpre, *cd );
				else {
					And * a = new And;
					a->add( d->actions[action]->pre->copy( *cd ) );
					doit->pre = a;
				}

				// copy old effects
				And * oldeff = dynamic_cast< And * >( d->actions[action]->eff );
				for ( unsigned l = 0; oldeff && l < oldeff->conds.size(); ++l )
					concurEffs |= addEff( cd, doit, oldeff->conds[l] );
				if ( !oldeff ) concurEffs |= addEff( cd, doit, d->actions[action]->eff );

				// add new parameters
				if ( i->second.size() > 1 || d->nodes[x]->upper > 1 )
					cd->addParams( name, StringVec( 2, "AGENT-COUNT" ) );

				// add new preconditions
				if ( i->second.size() > 1 || d->nodes[x]->upper > 1 ) {
					cd->addPre( 0, name, "ACTIVE-" + d->nodes[x]->name, d->nodes[x]->templates[k]->params );
					cd->addPre( 1, name, "TAKEN", IntVec( 1, 0 ) );
					cd->addPre( 0, name, "COUNT-" + d->nodes[x]->name, incvec( size, size + 1 ) );
					cd->addPre( 0, name, "CONSEC", incvec( size, size + 2 ) );
				}
				else cd->addPre( 0, name, "AFREE" );

				// add new effects
				if ( i->second.size() > 1 || d->nodes[x]->upper > 1 ) {
					cd->addEff( 0, name, "TAKEN", IntVec( 1, 0 ) );
					cd->addEff( 1, name, "COUNT-" + d->nodes[x]->name, incvec( size, size + 1 ) );
					cd->addEff( 0, name, "COUNT-" + d->nodes[x]->name, incvec( size + 1, size + 2 ) );
				}
			}

			if ( i->second.size() > 1 || d->nodes[x]->upper > 1 ) {
				std::string name = "END-" + d->nodes[x]->name;
				unsigned size = d->nodes[x]->params.size();
				Action * end = cd->createAction( name, d->typeList( d->nodes[x] ) );
				cd->addParams( name, StringVec( 1, "AGENT-COUNT" ) );

				cd->addPre( 0, name, "COUNT-" + d->nodes[x]->name, incvec( size, size + 1 ) );
				cd->addPre( 0, name, "SAT-" + d->nodes[x]->name, incvec( size, size + 1 ) );
				cd->addPre( 0, name, "ACTIVE-" + d->nodes[x]->name, incvec( 0, size ) );

				cd->addEff( 1, name, "COUNT-" + d->nodes[x]->name, incvec( size, size + 1 ) );
				if ( i->second.size() > 1 )
					cd->addEff( 0, name, "DONE-" + d->nodes[x]->name );
				else {
					cd->addEff( 0, name, concurEffs ? "ATEMP" : "AFREE" );
					cd->addEff( 1, name, "ACTIVE-" + d->nodes[x]->name, incvec( 0, size ) );
					Forall * f = new Forall;
					f->params = cd->convertTypes( StringVec( 1, "AGENT" ) );
					f->cond = new Not( new Ground( cd->preds.get( "TAKEN" ), incvec( size + 1, size + 2 ) ) );
					dynamic_cast< And * >( end->eff )->add( f );
				}
			}

			if ( i->second.size() > 1 && j + 1 == i->second.size() ) {
				std::string name = "FINISH-" + d->nodes[x]->name;
				unsigned size = d->nodes[x]->params.size();
				Action * finish = cd->createAction( name, d->typeList( d->nodes[x] ) );

				cd->addOrPre( name, "DONE-" + d->nodes[x]->name, "SKIPPED-" + d->nodes[x]->name );
				cd->addPre( 0, name, "ACTIVE-" + d->nodes[x]->name, incvec( 0, size ) );

				cd->addEff( 0, name, "ATEMP" );
				for ( unsigned k = 0; k < i->second.size(); ++k ) {
					cd->addEff( 1, name, "DONE-" + d->nodes[i->second[k]]->name );
					cd->addEff( 1, name, "SKIPPED-" + d->nodes[i->second[k]]->name );
					cd->addEff( 1, name, "USED-" + d->nodes[i->second[k]]->name );
					cd->addEff( 1, name, "ACTIVE-" + d->nodes[i->second[k]]->name, incvec( 0, size ) );
				}
				Forall * f = new Forall;
				f->params = cd->convertTypes( StringVec( 1, "AGENT" ) );
				f->cond = new Not( new Ground( cd->preds.get( "TAKEN" ), incvec( size, size + 1 ) ) );
				dynamic_cast< And * >( finish->eff )->add( f );
			}
		}
	}

	for ( std::set< unsigned >::iterator i = prob.begin(); i != prob.end(); ++i ) {
		std::string name = "ADD-" + d->preds[*i]->name;
		unsigned size = d->preds[*i]->params.size();
		cd->createAction( name, d->typeList( d->preds[*i] ) );
		cd->addPre( 0, name, "ATEMP" );
		cd->addPre( 0, name, "POS-" + d->preds[*i]->name, incvec( 0, size ) );
		cd->addPre( 1, name, "NEG-" + d->preds[*i]->name, incvec( 0, size ) );
		cd->addEff( 0, name, d->preds[*i]->name, incvec( 0, size ) );
		cd->addEff( 1, name, "POS-" + d->preds[*i]->name, incvec( 0, size ) );

		name = "DELETE-" + d->preds[*i]->name;
		cd->createAction( name, d->typeList( d->preds[*i] ) );
		cd->addPre( 0, name, "ATEMP" );
		cd->addPre( 1, name, "POS-" + d->preds[*i]->name, incvec( 0, size ) );
		cd->addPre( 0, name, "NEG-" + d->preds[*i]->name, incvec( 0, size ) );
		cd->addEff( 1, name, d->preds[*i]->name, incvec( 0, size ) );
		cd->addEff( 1, name, "NEG-" + d->preds[*i]->name, incvec( 0, size ) );
	}

	Action * freeit = cd->createAction( "FREE" );
	cd->addPre( 0, "FREE", "ATEMP" );
	for ( std::set< unsigned >::iterator i = prob.begin(); i != prob.end(); ++i ) {
		Forall * f = new Forall;
		f->params = cd->convertTypes( d->typeList( d->preds[*i] ) );
		And * a = new And;
		a->add( new Not( new Ground( cd->preds.get( "POS-" + d->preds[*i]->name ), incvec( 0, f->params.size() ) ) ) );
		a->add( new Not( new Ground( cd->preds.get( "NEG-" + d->preds[*i]->name ), incvec( 0, f->params.size() ) ) ) );
		f->cond = a;
		dynamic_cast< And * >( freeit->pre )->add( f );
	}
	cd->addEff( 0, "FREE", "AFREE" );
	cd->addEff( 1, "FREE", "ATEMP" );

	std::cout << *cd;

	// Generate single-agent instance

	unsigned nagents = d->types.get( "AGENT" )->objects.size();

	Instance * cins = new Instance( *cd );
	cins->name = ins->name;

	// add objects
	StringVec counts( 1, "ACOUNT-0" );
	for ( unsigned i = 1; i <= nagents; ++i ) {
		std::stringstream ss;
		ss << "ACOUNT-" << i;
		counts.push_back( ss.str() );
		cins->addObject( counts[i], "AGENT-COUNT" );
	}

	// create initial state
	for ( unsigned i = 0; i < ins->init.size(); ++i )
		if ( d->preds.index( ins->init[i]->name ) >= 0 )
			cins->addInit( ins->init[i]->name, d->objectList( ins->init[i] ) );
	cins->addInit( "AFREE" );
	for ( unsigned i = 1; i <= nagents; ++i ) {
		StringVec pars( 1, counts[i - 1] );
		pars.push_back( counts[i] );
		cins->addInit( "CONSEC", pars );
	}
	for ( unsigned i = 0; i < d->nodes.size(); ++i ) {
		VecMap::iterator j = ccs.find( d->mf[i] );
		if ( j->second.size() > 1 || d->nodes[i]->upper > 1 ) {
			for ( unsigned j = d->nodes[i]->lower; j <= d->nodes[i]->upper && j <= nagents; ++j )
				cins->addInit( "SAT-" + d->nodes[i]->name, StringVec( 1, counts[j] ) );
		}
	}

	// create goal state
	for ( unsigned i = 0; i < ins->goal.size(); ++i )
		cins->addGoal( ins->goal[i]->name, d->objectList( ins->goal[i] ) );
	cins->addGoal( "AFREE" );

	std::cerr << *cins;

	delete cins;
	delete cd;
	delete ins;
	delete d;

}
