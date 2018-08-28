import sys


def getDomainString(numTables, addMoveAgentAction):
    domPddl = "(define (domain tablemover)\n"
    domPddl += "(:requirements :typing :conditional-effects :multi-agent)\n"
    domPddl += "(:types agent block table - locatable\n"
    for i in range(0, numTables):
        domPddl += "\tside" + str(i) + " - side\n"
    domPddl += "\tlocatable room side\n"
    domPddl += ")\n"

    domPddl += "(:constants "
    for i in range(0, numTables):
        domPddl += "Table" + str(i) + " "
    domPddl += "- table)"

    domPddl += """
    (:predicates
    \t(on-table ?b - block ?t - table)
    \t(on-floor ?b - block)
    \t(down ?s - side)
    \t(up ?s - side)
    \t(clear ?s - side)
    \t(at-side ?a - agent ?s - side)
    \t(lifting ?a - agent ?s - side)
    \t(inroom ?l - locatable ?r - room)
    \t(available ?a - agent)
    \t(handempty ?a - agent)
    \t(holding ?a - agent ?b - block)
    \t(connected ?r1 ?r2 - room)
    )
    """

    domPddl += """
    (:action pickup-floor
        :agent ?a - agent
        :parameters (?b - block ?r - room)
        :precondition (and
                        (on-floor ?b)
                        (inroom ?a ?r)
                        (inroom ?b ?r)
                        (available ?a)
                        (handempty ?a)
                        (forall (?a2 - agent) (not (pickup-floor ?a2 ?b ?r)))
                    )
    	:effect	(and
                        (not (on-floor ?b))
                        (not (inroom ?b ?r))
                        (not (handempty ?a))
                        (holding ?a ?b)
                )
    )
    (:action putdown-floor
        :agent ?a - agent
    	:parameters (?b - block ?r - room)
    	:precondition (and
                            (available ?a)
                            (inroom ?a ?r)
                            (holding ?a ?b)
                        )
    	:effect	(and
                    (on-floor ?b)
                    (inroom ?b ?r)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
    )
    """

    if addMoveAgentAction:
        domPddl += """
    (:action move-agent
        :agent ?a - agent
        :parameters (?r1 ?r2 - room)
        :precondition (and
                        (available ?a)    
                        (inroom ?a ?r1)
                        (connected ?r1 ?r2)
                    )
        :effect (and
                    (not (inroom ?a ?r1))
                    (inroom ?a ?r2)
                )
    )
    """

    for i in range(0, numTables):
        domPddl += """
    (:action pickup-table-%d
        :agent ?a - agent
        :parameters (?b - block ?r - room)
        :precondition (and
                        (on-table ?b Table%d)
                        (inroom ?a ?r)
                        (inroom Table%d ?r)
                        (available ?a)
                        (handempty ?a)
                        (forall (?a2 - agent) (not (pickup-table-%d ?a2 ?b ?r)))
                    )
        :effect (and
                    (not (on-table ?b Table%d))
                    (not (handempty ?a))
                    (holding ?a ?b)
                )
    )
    (:action putdown-table-%d
        :agent ?a - agent
        :parameters (?b - block ?r - room)
        :precondition (and
                        (inroom ?a ?r)
                        (inroom Table%d ?r)
                        (available ?a)
                        (holding ?a ?b)
                        ; check table not lifted
                        (forall (?s - side%d)
                            (down ?s)
                        )
                        ; check table not intended to be lifted!
                        (forall (?a2 - agent ?s - side%d) (not (lift-side-%d ?a2 ?s)))
                    )
    	:effect	(and
                        (on-table ?b Table%d)
                        (handempty ?a)
                        (not (holding ?a ?b))
                    )
    )
    """ % (i, i, i, i, i, i, i, i, i, i, i)

        domPddl += """
    (:action to-table-%d
        :agent ?a - agent
    	:parameters (?r - room ?s - side%d)
    	:precondition (and
                        (clear ?s)
                        (inroom ?a ?r)
                        (inroom Table%d ?r)
                        (available ?a)
                        (forall (?a2 - agent) (not (to-table-%d ?a2 ?r ?s)))
                    )
    	:effect	(and
                    (not (clear ?s))
                    (at-side ?a ?s)
                    (not (available ?a))
                )
    )
    (:action leave-table-%d
        :agent ?a - agent
        :parameters (?s - side%d)
        :precondition (and
                        (at-side ?a ?s)
                        (not (lifting ?a ?s))
                    )
        :effect	(and
                        (clear ?s)
                        (not (at-side ?a ?s))
                        (available ?a)
                )
    )
    """ % (i, i, i, i, i, i)

        domPddl += """
    (:action move-table-%d
        :agent ?a - agent
        :parameters (?r1 ?r2 - room ?s - side%d)
        :precondition (and
                        (lifting ?a ?s)
                        (inroom ?a ?r1)
                        (connected ?r1 ?r2)
                        (exists (?a2 - agent ?s2 - side%d)
                            (and
                                (not (= ?s ?s2))
                                (move-table-%d ?a2 ?r1 ?r2 ?s2)
                            )
                        )
                    )
        :effect (and
                    (not (inroom ?a ?r1))
                    (not (inroom Table%d ?r1))
                    (inroom ?a ?r2)
                    (inroom Table%d ?r2)
                )
    )
    """ % (i, i, i, i, i, i)

        domPddl += """
    (:action lift-side-%d
        :agent ?a - agent
        :parameters (?s - side%d)
        :precondition (and
                        (down ?s)
                        (at-side ?a ?s)
                        (handempty ?a)
                        (forall (?a2 - agent ?s2 - side%d)
                            (not (lower-side-%d ?a2 ?s2))
                        )
                    )
        :effect (and
                    (not (down ?s))
                    (up ?s)
                    (lifting ?a ?s)
                    (not (handempty ?a))
                    (forall (?b - block ?r - room ?s2 - side%d)
                            (when (and
                                    (inroom Table%d ?r)
                                    (on-table ?b Table%d)
                                    (down ?s2)
                                    (forall (?a2 - agent)
                                            (not (lift-side-%d ?a2 ?s2))
                                    )
                                )
                                (and
                                    (on-floor ?b)
                                    (inroom ?b ?r)
                                    (not (on-table ?b Table%d))
                                )
                            )
                    )
    	)
    )
    """ % (i, i, i, i, i, i, i, i, i)

        domPddl += """
    (:action lower-side-%d
        :agent ?a - agent
        :parameters (?s - side%d)
        :precondition (and
                        (lifting ?a ?s)
                        (forall (?a2 - agent ?s2 - side%d)
                            (not (lift-side-%d ?a2 ?s2))
                        )
                    )
        :effect (and
                    (down ?s)
                    (not (up ?s))
                    (not (lifting ?a ?s))
                    (handempty ?a)
                    (forall (?b - block ?r - room ?s2 - side%d)
                            (when (and
                                    (inroom Table%d ?r)
                                    (on-table ?b Table%d)
                                    (up ?s2)
                                    (forall (?a2 - agent)
                                        (not (lower-side-%d ?a2 ?s2))
                                    )
                                )
                                (and
                                    (on-floor ?b)
                                    (inroom ?b ?r)
                                    (not (on-table ?b Table%d))
                                )
                            )
                    )
            )
    )
    """ % (i, i, i, i, i, i, i, i, i)

    domPddl += ")"

    return domPddl


def str2bool(v):
    if v.lower() in ('yes', 'true', 't', 'y', '1'):
        return True
    elif v.lower() in ('no', 'false', 'f', 'n', '0'):
        return False
    else:
        raise argparse.ArgumentTypeError('Boolean value expected.')


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print "Usage: python generate_domain.py <num-tables> <add-move-agent-action>"
        exit(-1)

    numTables = int(sys.argv[1])
    addMoveAgentAction = str2bool(sys.argv[2])

    domainPddl = getDomainString(numTables, addMoveAgentAction)

    with open("table_domain" + str(numTables) + ".pddl", 'w') as f:
        f.write(domainPddl)
