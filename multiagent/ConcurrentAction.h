
#pragma once

#include <parser/Action.h>

namespace parser { namespace multiagent {

using pddl::TokenStruct;
using pddl::Filereader;

class ConcurrentAction : public pddl::Action {

public:

	ConcurrentAction( const std::string & s ) : Action( s ) {}

	void print( std::ostream & s ) const {
		s << name << params << "\n";
		s << "Agent: " << params[0] << "\n";
		s << "Pre: " << pre;
		if ( eff ) s << "Eff: " << eff;
	}

//	void printParams( std::ostream & s, TokenStruct< std::string > & ts, pddl::Domain & d );

	void PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const override;

	void parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d );
};

} } // namespaces
