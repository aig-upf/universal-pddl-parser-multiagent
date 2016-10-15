
#pragma once

#include <parser/Domain.h>

#include <multiagent/NetworkNode.h>
#include <multiagent/AgentAction.h>

namespace parser { namespace multiagent {

// union-find: return the root in the tree that n belongs to
inline unsigned uf( UnsignedVec & mf, unsigned n ) {
	if ( mf[n] == n ) return n;
	else return mf[n] = uf( mf, mf[n] );
}

using pddl::Filereader;


class MultiagentDomain : public pddl::Domain {
public:
	using Base = pddl::Domain;
	
	bool multiagent, unfact, fact, net; // whether domain is multiagent and unfactored/factored/networked
	
	pddl::TokenStruct< NetworkNode * > nodes; // nodes of concurrency network
	PairVec edges;                            // edges of concurrency network

	UnsignedVec mf;                     // merge-find for connected components

	MultiagentDomain() : Base() {}

	MultiagentDomain( const std::string& s ) :
		Base(),
		multiagent( false ), unfact( false ), fact( false ), net( false )
	{
		parse(s);
	}

	~MultiagentDomain() {
		for ( unsigned i = 0; i < nodes.size(); ++i )
			delete nodes[i];
	}
	
	bool parseBlock(const std::string& t, Filereader& f) override {
		if (Base::parseBlock(t, f)) return true;
		
		if ( t == "CONCURRENCY-CONSTRAINT" ) parseNetworkNode( f );
		else if ( t == "POSITIVE-DEPENDENCE" ) parseNetworkEdge( f );
		else return false; // Unknown block type
		
		return true;
	}
	
	bool parseRequirement( const std::string& s ) override {
		if (Base::parseRequirement(s)) return true;
		
		// Parse possible requirements of a multi-agent domain
		if ( s == "MULTI-AGENT" ) multiagent = true;
		else if ( s == "UNFACTORED-PRIVACY" ) unfact = true;
		else if ( s == "FACTORED-PRIVACY" ) fact = true;
		else if ( s == "CONCURRENCY-NETWORK" ) net = true;
		else return false; // Unknown requirement
		
		return true;
	}
	
	void parseAction( Filereader & f ) override {
		if ( !preds.size() ) {
			std::cout << "Predicates needed before defining actions\n";
			exit(1);
		}

		f.next();
		pddl::Action * a = 0;

		// If domain is multiagent, parse using AgentAction
		if ( multiagent ) a = new AgentAction( f.getToken() );
		else a = new pddl::Action( f.getToken() );

		a->parse( f, types[0]->constants, *this );

		if ( DOMAIN_DEBUG ) std::cout << a << "\n";
		actions.insert( a );
	}
	
	void parseNetworkNode( Filereader & f ) {
		if ( !preds.size() || !actions.size() ) {
			std::cout << "Predicates and actions needed before defining a concurrency network\n";
			exit(1);
		}

		f.next();
		NetworkNode * n = new NetworkNode( f.getToken() );
		n->parse( f, types[0]->constants, *this );

		if ( DOMAIN_DEBUG ) std::cout << n << "\n";

		nodes.insert( n );
		mf.push_back( mf.size() );
	}

	void parseNetworkEdge( Filereader & f ) {
		f.next();
		int n1 = nodes.index( f.getToken( nodes ) );
		f.next();
		int n2 = nodes.index( f.getToken( nodes ) );
		edges.push_back( std::make_pair( n1, n2 ) );

		unsigned a = uf( mf, n1 ), b = uf( mf, n2 );
		if ( a != b ) mf[MIN( a, b )] = MAX( a, b );

		f.next();
		f.assert_token( ")" );
	}

	
	std::ostream& print_requirements(std::ostream& os) const override {
		os << "( :REQUIREMENTS";
		if ( equality ) os << " :EQUALITY";
		if ( strips ) os << " :STRIPS";
		if ( costs ) os << " :ACTION-COSTS";
		if ( adl ) os << " :ADL";
		if ( neg ) os << " :NEGATIVE-PRECONDITIONS";
		if ( condeffects ) os << " :CONDITIONAL-EFFECTS";
		if ( typed ) os << " :TYPING";
		if ( temp ) os << " :DURATIVE-ACTIONS";
		if ( nondet ) os << " :NON-DETERMINISTIC";
		if ( multiagent ) os << " :MULTI-AGENT";
		if ( unfact ) os << " :UNFACTORED-PRIVACY";
		if ( fact ) os << " :FACTORED-PRIVACY";
		if ( net ) os << " :CONCURRENCY-NETWORK";
		os << " )\n";
		return os;
	}
	
	std::ostream& print_addtional_blocks(std::ostream& os) const override {
		for ( unsigned i = 0; i < nodes.size(); ++i )
			nodes[i]->PDDLPrint( os, 0, pddl::TokenStruct< std::string >(), *this );

		for ( unsigned i = 0; i < edges.size(); ++i ) {
			os << "( :POSITIVE-DEPENDENCE ";
			os << nodes[edges[i].first]->name << " ";
			os << nodes[edges[i].second]->name << " )\n";
		}

		return os;
	}
};

} } // namespaces
