
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <map>
#include <sstream>
#include <vector>

#define PARS 10

enum Passage { DOOR, BRIDGE, BOAT, SWITCH };

Passage randomPassage( int * pars, int total ) {
	int i = 0, s = pars[0], r = rand() % total;
	while ( s <= r ) s += pars[++i];
	return Passage( i );
}

int main( int argc, char * argv[] ) {
	if ( argc < PARS ) {
		std::cout << "Usage: generate <agents> <iter> <lo> <hi> <step> <door> <bridge> <boat> <switch>\n";
		std::exit( 0 );
	}

	int pars[PARS], total = 0;
	for ( unsigned i = 1; i < PARS; ++i ) {
		std::istringstream is( argv[i] );
		is >> pars[i];
		if ( i >= 6 ) total += pars[i];
	}

	for ( int i = pars[3]; i <= pars[4]; i += pars[5] )
		for ( int j = 1; j <= pars[2]; ++j ) {
			int types[4] = { 0, 0, 0, 0 }, indices[4] = { 0, 0, 0, 0 };
			typedef std::map< int, Passage > PMap;
			typedef std::map< int, PMap > IPMap;
			IPMap m;
			for ( int k = 0; k < i*i; ++k ) {
				PMap h;
				int x = k / i, y = k % i;
				if ( x + 1 < i ) {
					Passage p = randomPassage( pars + 6, total );
					types[p]++;
					if ( p == 3 ) types[0]++;
					h[( x + 1 )*i + y] = p;
				}
				if ( y + 1 < i ) {
					Passage p = randomPassage( pars + 6, total );
					types[p]++;
					if ( p == 3 ) types[0]++;
					h[x*i + y + 1] = p;
				}
				if ( h.size() ) m[k] = h;
			}

			std::ostringstream os;
			os << "maze" << pars[1] << "_" << i << "_" << j << ".pddl";
			std::ofstream f( os.str().c_str() );
			f << "(define (problem maze" << pars[1] << "_" << i << "_" << j << ") (:domain maze)\n";
			f << "(:objects\n\t";
			for ( int k = 1; k <= pars[1]; ++k ) f << "a" << k << " ";
			f << "- agent\n\t";
			for ( int k = 1; k <= i; ++k )
				for ( int l = 1; l <= i; ++l ) f << "loc" << k << "x" << l << " ";
			f << "- location\n\t";
			for ( int k = 1; k <= types[0]; ++k ) f << "d" << k << " ";
			f << "- door\n\t";
			for ( int k = 1; k <= types[1]; ++k ) f << "b" << k << " ";
			f << "- bridge\n\t";
			for ( int k = 1; k <= types[2]; ++k ) f << "bt" << k << " ";
			f << "- boat\n\t";
			for ( int k = 1; k <= types[3]; ++k ) f << "s" << k << " ";
			f << "- switch\n)\n(:init\n";
			for ( int k = 1; k <= pars[1]; ++k ) {
				int r = rand() % ( i * i );
				f << "\t(at a" << k << " loc" << r/i + 1 << "x" << r%i + 1 << ")\n";
			}
			for ( IPMap::iterator k = m.begin(); k != m.end(); ++k )
				for ( PMap::iterator l = k->second.begin(); l != k->second.end(); ++l ) {
					int x1 = k->first/i+1, y1 = k->first%i+1, x2 = l->first/i+1, y2 = l->first%i+1;
					switch ( l->second ) {
						case DOOR: {
							f << "\t(has-door d" << ++indices[0];
							f << " loc" << x1 << "x" << y1 << " loc" << x2 << "x" << y2 << ")\n";
							f << "\t(has-door d" << indices[0];
							f << " loc" << x2 << "x" << y2 << " loc" << x1 << "x" << y1 << ")\n";
							break;
						}
						case BRIDGE: {
							f << "\t(has-bridge b" << ++indices[1];
							f << " loc" << x1 << "x" << y1 << " loc" << x2 << "x" << y2 << ")\n";
							f << "\t(has-bridge b" << indices[1];
							f << " loc" << x2 << "x" << y2 << " loc" << x1 << "x" << y1 << ")\n";
							break;
						}
						case BOAT: {
							f << "\t(has-boat bt" << ++indices[2];
							f << " loc" << x1 << "x" << y1 << " loc" << x2 << "x" << y2 << ")\n";
							f << "\t(has-boat bt" << indices[2];
							f << " loc" << x2 << "x" << y2 << " loc" << x1 << "x" << y1 << ")\n";
							break;
						}
						case SWITCH: {
							int r = rand() % ( i * i );
							f << "\t(has-door d" << ++indices[0];
							f << " loc" << x1 << "x" << y1 << " loc" << x2 << "x" << y2 << ")\n";
							f << "\t(has-door d" << indices[0];
							f << " loc" << x2 << "x" << y2 << " loc" << x1 << "x" << y1 << ")\n";
							f << "\t(blocked loc" << x1 << "x" << y1 << " loc" << x2 << "x" << y2 << ")\n";
							f << "\t(blocked loc" << x2 << "x" << y2 << " loc" << x1 << "x" << y1 << ")\n";
							f << "\t(has-switch s" << ++indices[3] << " loc" << r/i+1 << "x" << r%i+1;
							f << " loc" << x1 << "x" << y1 << " loc" << x2 << "x" << y2 << ")\n";
							break;
						}
					}
				}
			f << ")\n(:goal (and\n";
			for ( int k = 1; k <= pars[1]; ++k ) {
				int r = rand() % ( i * i );
				f << "\t(at a" << k << " loc" << r/i + 1 << "x" << r%i + 1 << ")\n";
			}
			f << "))\n)\n";
			f.close();
		}
}
