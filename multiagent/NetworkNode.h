
#pragma once

#include <parser/ParamCond.h>

namespace parser { namespace multiagent {

using pddl::Filereader;
using pddl::Domain;

class NetworkNode : public pddl::ParamCond {
public:
	unsigned lower, upper;
	pddl::ParamCondVec templates;
  
	NetworkNode( const std::string & s )
		: pddl::ParamCond( s ), lower( 0 ), upper( 0 ) {}

	NetworkNode( const NetworkNode * n, Domain & d )
		: pddl::ParamCond( n ), lower( n->lower ), upper( n->upper ) {
		for ( unsigned i = 0; i < n->templates.size(); ++i )
			templates.push_back( ( pddl::ParamCond * )n->templates[i]->copy( d ) );
	}

	~NetworkNode() {
		for ( unsigned i = 0; i < templates.size(); ++i )
			delete templates[i];
	}

	void print( std::ostream & stream ) const {
		stream << "Network node ";
		pddl::ParamCond::print( stream );
		stream << "  <" << lower << "," << upper << ">";
		for ( unsigned i = 0; i < templates.size(); ++i )
			stream << "\n  Template: " << templates[i];
	}

	void PDDLPrint( std::ostream & s, unsigned indent, const pddl::TokenStruct< std::string > & ts, const Domain & d ) const override;

	void parse( pddl::Filereader & f, pddl::TokenStruct< std::string > & ts, Domain & d );

	void addParams( int m, unsigned n ) {
	}

	Condition * copy( Domain & d ) {
		return new NetworkNode( this, d );
	}
	
};

} } // namespaces
