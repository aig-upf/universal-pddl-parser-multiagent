
#include <parser/Domain.h>

#include <multiagent/ConcurrencyCondition.h>

namespace parser { namespace multiagent {

void ConcurrencyCondition::PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const {
	if ( cond ) {
		TokenStruct< std::string > astruct;
		std::stringstream ss;
		ss << "?" << d.types[params[0]]->name;
		astruct.insert( ss.str() );
	
		tabindent( s, indent );
		printParams( 0, s, astruct, d );
		
		cond->PDDLPrint( s, indent, ts, d );
	}
}

void ConcurrencyCondition::parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d ) {
	f.next();
	f.assert_token( "(" );
	
	TokenStruct< std::string > fs = f.parseTypedList( true, d.types );
	params = d.convertTypes( fs.types );
	
	TokenStruct< std::string > fstruct( ts );
	fstruct.append( fs );
	
	f.next();
	f.assert_token( "(" );

	if ( f.getChar() != ')' ) {
		cond = createCondition( f, d );
		cond->parse( f, ts, d );
	}
	else ++f.c;
}

} } // namespaces
