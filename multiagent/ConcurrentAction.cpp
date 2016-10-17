
#include <parser/Domain.h>

#include <multiagent/ConcurrentAction.h>
#include <multiagent/ConcurrencyCondition.h>

namespace parser { namespace multiagent {

void ConcurrentAction::PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const {

}

void ConcurrentAction::parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d ) {

}

void ConcurrentAction::parseConcurrencyConditions( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d ) {
	f.next();
	f.assert_token( ":CONCURRENT" );
	
	concurrent = new ConcurrencyCondition();
	concurrent->parse( f, ts, d );
}

} } // namespaces
