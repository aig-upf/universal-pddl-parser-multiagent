
#pragma once

#include <parser/Domain.h>

#include <multiagent/ConcurrentAction.h>

namespace parser { namespace multiagent {

using pddl::Filereader;

class ConcurrencyDomain : public pddl::Domain {
public:
	using Base = pddl::Domain;

	bool multiagent;

	ConcurrencyDomain() : Base(), multiagent( false ) {}

	ConcurrencyDomain( const std::string& s ) : Base(), multiagent( false ) {
		parse(s);
	}

	bool parseBlock(const std::string& t, Filereader& f) override {
		if (Base::parseBlock(t, f)) return true;
		
		return false;
	}
	
	bool parseRequirement( const std::string& s ) override {
		if (Base::parseRequirement(s)) return true;
		
		// Parse possible requirements of a multi-agent domain
		if ( s == "MULTI-AGENT" ) multiagent = true;
		
		return false;
	}
	
	void parseAction( Filereader & f ) override {
		if ( !preds.size() ) {
			std::cout << "Predicates needed before defining actions\n";
			exit(1);
		}

		f.next();
		pddl::Action * a = 0;

		// If domain is multiagent, parse using ConcurrentAction
		if ( multiagent ) a = new ConcurrentAction( f.getToken() );
		else a = new pddl::Action( f.getToken() );

		a->parse( f, types[0]->constants, *this );

		if ( DOMAIN_DEBUG ) std::cout << a << "\n";
		actions.insert( a );
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
		os << " )\n";
		return os;
	}
};

} } // namespaces
