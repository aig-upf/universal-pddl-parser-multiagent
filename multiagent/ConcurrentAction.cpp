
#include <parser/Domain.h>

#include <multiagent/ConcurrentAction.h>
#include <multiagent/ConcurrencyPredicate.h>
#include <multiagent/ConcurrencyDomain.h>

namespace parser { namespace multiagent {

void ConcurrentAction::PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const {
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

void ConcurrentAction::parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d ) {
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

	ConcurrencyPredicate * lll = new ConcurrencyPredicate( name );
	lll->params = d.convertTypes( astruct.types );
	std::cout << lll << std::endl;
	ConcurrencyDomain & cd = static_cast< ConcurrencyDomain& >( d );
	cd.cpreds.insert( lll );

	parseConditions( f, astruct, d );
}

} } // namespaces
