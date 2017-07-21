
#pragma once

#include <parser/Ground.h>

namespace parser { namespace multiagent {

using pddl::TokenStruct;
using pddl::Filereader;

class ConcurrencyGround : public pddl::Ground {

public:

	std::map< int, std::string > constants;

	ConcurrencyGround()
		: Ground() {}

	ConcurrencyGround( const std::string s, const IntVec & p = IntVec() )
		: Ground( s, p ) {}

	ConcurrencyGround( pddl::Lifted * l, const IntVec & p = IntVec() )
		: Ground( l, p ) {}

	ConcurrencyGround( const pddl::Ground * g, pddl::Domain & d )
		: Ground( g, d ) {}

	void parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d );

	void setLifted( pddl::Lifted * l, pddl::Domain & d );
};

} } // namespaces
