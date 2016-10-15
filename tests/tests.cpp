
#include <fstream>
#include <sstream>

#include <minicppunit/MiniCppUnit.h>
#include <parser/Instance.h>
#include <multiagent/MultiagentDomain.h>

class MultiagentTests : public TestFixture<MultiagentTests>
{
public:
	TEST_FIXTURE( MultiagentTests )
	{
		TEST_CASE( multiagentTest );
	}

	template < typename T >
	void checkEqual( T & prob, const std::string & file ) {
		std::ifstream f(file.c_str());
		if (!f) throw std::runtime_error(std::string("Failed to open file '") + file + "'");
		std::string s, t;
		
		while(std::getline(f, s)){
			t += s + "\n";
		}

		std::ostringstream ds;
		ds << prob;
		ASSERT_EQUALS( t, ds.str() );
		std::ofstream of("ins.txt");
		of<<ds.str();
	}

	void multiagentTest() {
		parser::multiagent::MultiagentDomain dom( "domains/Multilog_dom.pddl" );
		parser::pddl::Instance ins( dom, "domains/Multilog_ins.pddl" );

		checkEqual( dom, "tests/expected/Multilog_dom.pddl" );
		checkEqual( ins, "tests/expected/Multilog_ins.pddl" );
	}
};

REGISTER_FIXTURE( MultiagentTests )

