
#include <parser/Domain.h>

#include <multiagent/AgentAction.h>

namespace parser { namespace multiagent {

void AgentAction::PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const {
	s << "( :ACTION " << name << "\n";

	TokenStruct< std::string > astruct;

	std::stringstream ss;
	ss << "?" << d.types[params[0]]->name;
	astruct.insert( ss.str() );

	s << "  :AGENT " << astruct[0];
	if ( d.typed ) s << " - " << d.types[params[0]]->name;
	s << "\n";

	s << "  :PARAMETERS ";

	printParams( 1, s, astruct, d );

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

void AgentAction::parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d ) {
	TokenStruct< std::string > astruct;

	f.next();
	f.assert_token( ":AGENT" );
	astruct.insert( f.getToken() );
	if ( d.typed ) {
		f.next();
		f.assert_token( "-" );
		astruct.types.push_back( f.getToken( d.types ) );
	}
	else astruct.types.push_back( "OBJECT" );

	f.next();
	f.assert_token( ":PARAMETERS" );
	f.assert_token( "(" );
	astruct.append( f.parseTypedList( true, d.types ) );
	params = d.convertTypes( astruct.types );

	parseConditions( f, astruct, d );
}

} } // namespaces
