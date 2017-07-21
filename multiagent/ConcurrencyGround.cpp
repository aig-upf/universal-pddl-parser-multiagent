#include <parser/Domain.h>

#include <multiagent/ConcurrencyGround.h>

namespace parser { namespace multiagent {

void ConcurrencyGround::parse( Filereader & f, TokenStruct< std::string > & ts, pddl::Domain & d ) {
	f.next();

	std::string lastToken = f.getToken();
	while ( lastToken != "" ) {
		int k = ts.index( lastToken );
		if ( k >= 0 ) params.push_back( k );
		else {
			constants[params.size()] = lastToken;
			params.push_back( -1 );
		}

		f.next();
		lastToken = f.getToken();
	}

	f.assert_token( ")" );
}

void ConcurrencyGround::setLifted( pddl::Lifted * l, pddl::Domain & d ) {
	lifted = l;
	for ( auto it = constants.begin(); it != constants.end(); ++it ) {
		std::pair< bool, int > p = d.types[lifted->params[it->first]]->parseConstant( it->second );
		if ( p.first ) params[it->first] = p.second;
		else {
			std::cout << "error" << std::endl;
		}
	}
}

} } // namespaces
