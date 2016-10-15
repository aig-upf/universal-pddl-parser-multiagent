
#pragma once

#include <parser/ParamCond.h>

namespace parser { namespace multiagent { 

using pddl::TokenStruct;
using pddl::Filereader;

class ConcurrencyCondition : public pddl::ParamCond {

public:
	Condition * cond;

	ConcurrencyCondition()
		: cond( 0 ) {}

	ConcurrencyCondition( const ConcurrencyCondition * c, pddl::Domain & d)
		: ParamCond( c ), cond( 0 ) {
		if ( c-> cond ) cond = c->cond->copy(d);
	}

	~ConcurrencyCondition() {
		if ( cond ) delete cond;
	}

	void PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const override;

	void parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d ) override;

	void addParams( int m, unsigned n ) {
		cond->addParams( m, n );
	}

	Condition * copy( pddl::Domain & d ) {
		return new ConcurrencyCondition( this, d );
	}

};

} } // namespaces
