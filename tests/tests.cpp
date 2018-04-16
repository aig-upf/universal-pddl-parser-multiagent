
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
        TEST_CASE( multiagentMazeTest );
        TEST_CASE( multiagentWorkshopTest );
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

    void multiagentMazeTest() {
        parser::multiagent::MultiagentDomain dom( "domains/maze/domain/maze_dom_cn.pddl" );
        parser::pddl::Instance ins( dom, "domains/maze/problems/maze5_4_1.pddl" );

        checkEqual( dom, "tests/expected/maze/maze_dom_cn.pddl" );
        checkEqual( ins, "tests/expected/maze/maze5_4_1.pddl" );
    }

    void multiagentWorkshopTest() {
        parser::multiagent::MultiagentDomain dom( "domains/workshop/domain/workshop_dom_cn.pddl" );
        parser::pddl::Instance ins( dom, "domains/workshop/problems/workshop2_2_2_4.pddl" );

        checkEqual( dom, "tests/expected/workshop/workshop_dom_cn.pddl" );
        checkEqual( ins, "tests/expected/workshop/workshop2_2_2_4.pddl" );
    }
};

class ConcurrencyTests : public TestFixture<ConcurrencyTests>
{
public:
    TEST_FIXTURE( ConcurrencyTests )
    {
        TEST_CASE( concurrencyMazeTest );
        TEST_CASE( concurrencyWorkshopTest );
        TEST_CASE( concurrencyTablemoverTest );
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

    void concurrencyMazeTest() {
        parser::multiagent::ConcurrencyDomain dom( "domains/maze/domain/maze_dom_cal.pddl" );
        parser::pddl::Instance ins( dom, "domains/maze/problems/maze5_4_1.pddl" );

        checkEqual( dom, "tests/expected/maze/maze_dom_cal.pddl" );
        checkEqual( ins, "tests/expected/maze/maze5_4_1.pddl" );
    }

    void concurrencyWorkshopTest() {
        parser::multiagent::ConcurrencyDomain dom( "domains/workshop/domain/workshop_dom_cal.pddl" );
        parser::pddl::Instance ins( dom, "domains/workshop/problems/workshop2_2_2_4.pddl" );

        checkEqual( dom, "tests/expected/workshop/workshop_dom_cal.pddl" );
        checkEqual( ins, "tests/expected/workshop/workshop2_2_2_4.pddl" );
    }

    void concurrencyTablemoverTest() {
        parser::multiagent::ConcurrencyDomain dom( "domains/tablemover/domain/table_domain1.pddl" );
        parser::pddl::Instance ins( dom, "domains/tablemover/problems/table4_2_1.pddl" );

        checkEqual( dom, "tests/expected/tablemover/table_domain1.pddl" );
        checkEqual( ins, "tests/expected/tablemover/table4_2_1.pddl" );
    }
};

REGISTER_FIXTURE( MultiagentTests )
REGISTER_FIXTURE( ConcurrencyTests )
