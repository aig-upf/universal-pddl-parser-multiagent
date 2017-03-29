
#include <parser/Basic.h>

int main( int argc, char * argv[] ) {
	if ( argc < 3 ) {
		std::cout << "Usage: compress <solution> <output>\n";
		std::exit( 0 );
	}

	typedef std::map< unsigned, std::string > Map;
	typedef std::map< unsigned, Map > UMap;

	char c;
	UMap m;
	unsigned a;
	std::string s, t, u;
	std::set< unsigned > h;
	std::ifstream f( argv[1] );
	unsigned i, j, k = 0, n = 0;
	std::vector< std::pair< unsigned, std::string > > v;
	for ( i = 0; getline( f, s ); ++i ) {
		std::istringstream is( s );
		is >> c >> s;

		if ( c == ';' ) // ignore comments
			continue;

		unsigned ix = s.find( '-' );
		if ( ix != std::string::npos ) {
			t = s.substr( 0, ix );
			s = s.substr( ix + 1 );
		}

		if ( t == "end" ) {
			--i;
			while ( j < i && v[j].first < k ) v[j++].first = k;
			continue;
		}
		else if ( t == "start" ) j = i;

		is >> c >> a;

		if ( h.find( a ) != h.end() ) {
			++k;
			h.clear();
		}
		h.insert( a );
		n = MAX( n, a );

		std::ostringstream os;
		os << "(" << s << " a" << a;
		for ( int j = 0; j < 3 + ( s == "pushswitch" ); ++j ) {
			is >> u;
			os << " " << u;
		}
		if ( t == "do" ) os << ")";
		v.push_back( std::make_pair( k, os.str() ) );
		//std::cout << k << "," << os.str() << "\n";
	}
	f.close();

	std::ofstream g( argv[2] );
	g << n << " " << 0 << " " << k+1 << "\n";
	for ( unsigned i = 1; i <= n; ++i ) {
		g << "a" << i << "\n";
		for ( unsigned j = 0; j < v.size(); ++j ) {
			std::istringstream is( v[j].second );
			is >> c >> t >> c >> a;
			if ( i == a ) g << v[j].first << ": " << v[j].second << "\n";
		}
		g << "\n";
	}
	g << v.size() << " " << k+1 << "\n";
	g.close();
}
