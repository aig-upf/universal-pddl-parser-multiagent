
#include <parser/Domain.h>

#include <multiagent/ConcurrentAction.h>

namespace parser { namespace multiagent {

void ConcurrentAction::PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const {
	s << "( :ACTION " << name << "\n";

	TokenStruct< std::string > astruct;

	s << "  :PARAMETERS ";

	printParams( 0, s, astruct, d );

	s << "  :PRECONDITION\n";
	if ( pre ) pre->PDDLPrint( s, 1, astruct, d );
	else s << "\t()";
	s << "\n";

	s << "  :EFFECT\n";
	if ( eff ) eff->PDDLPrint( s, 1, astruct, d );
	else s << "\t()";
	s << "\n";

	s << ")\n";
}

void ConcurrentAction::parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d ) {
	TokenStruct< std::string > astruct;

	f.next();
	f.assert_token( ":PARAMETERS" );
	f.assert_token( "(" );
	astruct.append( f.parseTypedList( true, d.types ) );
	params = d.convertTypes( astruct.types );

	parseConditions( f, astruct, d );
}

} } // namespaces
