
#include <parser/Instance.h>

using namespace parser::pddl;

int main( int argc, char *argv[] ) {
	if ( argc < 3 ) {
		std::cout << "Usage: ./serialize.bin <domain.pddl> <task.pddl>\n";
		exit(1);
	}

	return 0;
} 
