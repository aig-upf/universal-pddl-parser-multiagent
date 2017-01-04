
#include <fstream>
#include <sstream>

#include <minicppunit/MiniCppUnit.h>
#include <parser/Instance.h>
#include <multiagent/MultiagentDomain.h>
#include <multiagent/ConcurrencyDomain.h>

class MultiagentTests : public TestFixture<MultiagentTests>
{
public:
	TEST_FIXTURE( MultiagentTests )
	{
		TEST_CASE( multiagentMultilogTest );
		TEST_CASE( multiagentTablemoverTest );
		TEST_CASE( concurrencyTablemoverTest );
		TEST_CASE( concurrencySimpleTablemoverTest );
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

	void multiagentMultilogTest() {
		parser::multiagent::MultiagentDomain dom( "domains/multilog/Multilog_dom.pddl" );
		parser::pddl::Instance ins( dom, "domains/multilog/Multilog_ins.pddl" );

		checkEqual( dom, "tests/expected/multilog/Multilog_dom.pddl" );
		checkEqual( ins, "tests/expected/multilog/Multilog_ins.pddl" );
	}
	
	void multiagentTablemoverTest() {
		parser::multiagent::MultiagentDomain dom( "domains/tablemover/Tablemover_dom_cn.pddl" );
		parser::pddl::Instance ins( dom, "domains/tablemover/Tablemover_ins.pddl" );

		checkEqual( dom, "tests/expected/tablemover/Tablemover_dom_cn.pddl" );
		checkEqual( ins, "tests/expected/tablemover/Tablemover_ins.pddl" );
	}
	
	void concurrencyTablemoverTest() {
		parser::multiagent::ConcurrencyDomain dom( "domains/tablemover/Tablemover_dom_cal.pddl" );
		parser::pddl::Instance ins( dom, "domains/tablemover/Tablemover_ins.pddl" );

		checkEqual( dom, "tests/expected/tablemover/Tablemover_dom_cal.pddl" );
		checkEqual( ins, "tests/expected/tablemover/Tablemover_ins.pddl" );
	}
	
	void concurrencySimpleTablemoverTest() {
		parser::multiagent::ConcurrencyDomain dom( "domains/tablemover/Tablemover_simple_dom_cal.pddl" );
		parser::pddl::Instance ins( dom, "domains/tablemover/Tablemover_simple_ins.pddl" );

		checkEqual( dom, "tests/expected/tablemover/Tablemover_simple_dom_cal.pddl" );
		checkEqual( ins, "tests/expected/tablemover/Tablemover_simple_ins.pddl" );
	}
};

REGISTER_FIXTURE( MultiagentTests )

