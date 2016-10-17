
#pragma once

#include <parser/Action.h>

namespace parser { namespace multiagent {

using pddl::TokenStruct;
using pddl::Filereader;

class ConcurrentAction : public pddl::Action {

public:
	Condition * concurrent;

	ConcurrentAction( const std::string & s )
		: Action( s ), concurrent( 0 ) {}

	~ConcurrentAction() {
		if ( concurrent ) delete concurrent;
	}

	void print( std::ostream & s ) const {
	
	}

	void PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const override;
	
	void parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d );

	void parseConcurrencyConditions( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d );
};

} } // namespaces
