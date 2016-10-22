
#include <parser/Domain.h>

#include <multiagent/ConcurrencyCondition.h>

namespace parser { namespace multiagent {

void ConcurrencyCondition::PDDLPrint( std::ostream & s, unsigned indent, const TokenStruct< std::string > & ts, const pddl::Domain & d ) const {
	TokenStruct< std::string > fstruct( ts );

	tabindent( s, indent );
	printParams( 0, s, fstruct, d );

	if ( cond ) cond->PDDLPrint( s, indent, fstruct, d );
	else {
		tabindent( s, indent );
		s << "()";
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
		cond->parse( f, fstruct, d );
	}
	else ++f.c;
}

} } // namespaces
