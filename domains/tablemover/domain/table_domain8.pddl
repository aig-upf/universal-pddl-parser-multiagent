(define (domain tablemover)
(:requirements :typing :conditional-effects :multi-agent)
(:types agent block table - locatable
	side0 - side
	side1 - side
	side2 - side
	side3 - side
	side4 - side
	side5 - side
	side6 - side
	side7 - side
	locatable room side
)
(:constants Table0 Table1 Table2 Table3 Table4 Table5 Table6 Table7 - table)
(:predicates
	(on-table ?b - block ?t - table)
	(on-floor ?b - block)
	(down ?s - side)
	(up ?s - side)
	(clear ?s - side)
	(at-side ?a - agent ?s - side)
	(lifting ?a - agent ?s - side)
	(inroom ?l - locatable ?r - room)
	(available ?a - agent)
	(handempty ?a - agent)
	(holding ?a - agent ?b - block)
	(connected ?r1 ?r2 - room)
)

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
;(:action move-agent
;    :agent ?a - agent
;    :parameters (?r1 ?r2 - room)
;    :precondition (and
;                    (available ?a)
;                    (inroom ?a ?r1)
;                    (connected ?r1 ?r2)
;                )
;    :effect (and
;                (not (inroom ?a ?r1))
;                (inroom ?a ?r2)
;            )
;)

(:action pickup-table-0
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (on-table ?b Table0)
                    (inroom ?a ?r)
                    (inroom Table0 ?r)
                    (available ?a)
                    (handempty ?a)
                    (forall (?a2 - agent) (not (pickup-table-0 ?a2 ?b ?r)))
                )
    :effect (and
                (not (on-table ?b Table0))
                (not (handempty ?a))
                (holding ?a ?b)
            )
)
(:action putdown-table-0
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (inroom ?a ?r)
                    (inroom Table0 ?r)
                    (available ?a)
                    (holding ?a ?b)
                    ; check table not lifted
                    (forall (?s - side0)
                        (down ?s)
                    )
                    ; check table not intended to be lifted!
                    (forall (?a2 - agent ?s - side0) (not (lift-side-0 ?a2 ?s)))
                )
	:effect	(and
                    (on-table ?b Table0)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
)

(:action to-table-0
    :agent ?a - agent
	:parameters (?r - room ?s - side0)
	:precondition (and
                    (clear ?s)
                    (inroom ?a ?r)
                    (inroom Table0 ?r)
                    (available ?a)
                    (forall (?a2 - agent) (not (to-table-0 ?a2 ?r ?s)))
                )
	:effect	(and
                (not (clear ?s))
                (at-side ?a ?s)
                (not (available ?a))
            )
)
(:action leave-table-0
    :agent ?a - agent
    :parameters (?s - side0)
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

(:action move-table-0
    :agent ?a - agent
    :parameters (?r1 ?r2 - room ?s - side0)
    :precondition (and
                    (lifting ?a ?s)
                    (inroom ?a ?r1)
                    (connected ?r1 ?r2)
                    (exists (?a2 - agent ?s2 - side0)
                        (and
                            (not (= ?s ?s2))
                            (move-table-0 ?a2 ?r1 ?r2 ?s2)
                        )
                    )
                )
    :effect (and
                (not (inroom ?a ?r1))
                (not (inroom Table0 ?r1))
                (inroom ?a ?r2)
                (inroom Table0 ?r2)
            )
)

(:action lift-side-0
    :agent ?a - agent
    :parameters (?s - side0)
    :precondition (and
                    (down ?s)
                    (at-side ?a ?s)
                    (handempty ?a)
                    (forall (?a2 - agent ?s2 - side0)
                        (not (lower-side-0 ?a2 ?s2))
                    )
                )
    :effect (and
                (not (down ?s))
                (up ?s)
                (lifting ?a ?s)
                (not (handempty ?a))
                (forall (?b - block ?r - room ?s2 - side0)
                        (when (and
                                (inroom Table0 ?r)
                                (on-table ?b Table0)
                                (down ?s2)
                                (forall (?a2 - agent)
                                        (not (lift-side-0 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table0))
                            )
                        )
                )
	)
)

(:action lower-side-0
    :agent ?a - agent
    :parameters (?s - side0)
    :precondition (and
                    (lifting ?a ?s)
                    (forall (?a2 - agent ?s2 - side0)
                        (not (lift-side-0 ?a2 ?s2))
                    )
                )
    :effect (and
                (down ?s)
                (not (up ?s))
                (not (lifting ?a ?s))
                (handempty ?a)
                (forall (?b - block ?r - room ?s2 - side0)
                        (when (and
                                (inroom Table0 ?r)
                                (on-table ?b Table0)
                                (up ?s2)
                                (forall (?a2 - agent)
                                    (not (lower-side-0 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table0))
                            )
                        )
                )
        )
)

(:action pickup-table-1
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (on-table ?b Table1)
                    (inroom ?a ?r)
                    (inroom Table1 ?r)
                    (available ?a)
                    (handempty ?a)
                    (forall (?a2 - agent) (not (pickup-table-1 ?a2 ?b ?r)))
                )
    :effect (and
                (not (on-table ?b Table1))
                (not (handempty ?a))
                (holding ?a ?b)
            )
)
(:action putdown-table-1
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (inroom ?a ?r)
                    (inroom Table1 ?r)
                    (available ?a)
                    (holding ?a ?b)
                    ; check table not lifted
                    (forall (?s - side1)
                        (down ?s)
                    )
                    ; check table not intended to be lifted!
                    (forall (?a2 - agent ?s - side1) (not (lift-side-1 ?a2 ?s)))
                )
	:effect	(and
                    (on-table ?b Table1)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
)

(:action to-table-1
    :agent ?a - agent
	:parameters (?r - room ?s - side1)
	:precondition (and
                    (clear ?s)
                    (inroom ?a ?r)
                    (inroom Table1 ?r)
                    (available ?a)
                    (forall (?a2 - agent) (not (to-table-1 ?a2 ?r ?s)))
                )
	:effect	(and
                (not (clear ?s))
                (at-side ?a ?s)
                (not (available ?a))
            )
)
(:action leave-table-1
    :agent ?a - agent
    :parameters (?s - side1)
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

(:action move-table-1
    :agent ?a - agent
    :parameters (?r1 ?r2 - room ?s - side1)
    :precondition (and
                    (lifting ?a ?s)
                    (inroom ?a ?r1)
                    (connected ?r1 ?r2)
                    (exists (?a2 - agent ?s2 - side1)
                        (and
                            (not (= ?s ?s2))
                            (move-table-1 ?a2 ?r1 ?r2 ?s2)
                        )
                    )
                )
    :effect (and
                (not (inroom ?a ?r1))
                (not (inroom Table1 ?r1))
                (inroom ?a ?r2)
                (inroom Table1 ?r2)
            )
)

(:action lift-side-1
    :agent ?a - agent
    :parameters (?s - side1)
    :precondition (and
                    (down ?s)
                    (at-side ?a ?s)
                    (handempty ?a)
                    (forall (?a2 - agent ?s2 - side1)
                        (not (lower-side-1 ?a2 ?s2))
                    )
                )
    :effect (and
                (not (down ?s))
                (up ?s)
                (lifting ?a ?s)
                (not (handempty ?a))
                (forall (?b - block ?r - room ?s2 - side1)
                        (when (and
                                (inroom Table1 ?r)
                                (on-table ?b Table1)
                                (down ?s2)
                                (forall (?a2 - agent)
                                        (not (lift-side-1 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table1))
                            )
                        )
                )
	)
)

(:action lower-side-1
    :agent ?a - agent
    :parameters (?s - side1)
    :precondition (and
                    (lifting ?a ?s)
                    (forall (?a2 - agent ?s2 - side1)
                        (not (lift-side-1 ?a2 ?s2))
                    )
                )
    :effect (and
                (down ?s)
                (not (up ?s))
                (not (lifting ?a ?s))
                (handempty ?a)
                (forall (?b - block ?r - room ?s2 - side1)
                        (when (and
                                (inroom Table1 ?r)
                                (on-table ?b Table1)
                                (up ?s2)
                                (forall (?a2 - agent)
                                    (not (lower-side-1 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table1))
                            )
                        )
                )
        )
)

(:action pickup-table-2
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (on-table ?b Table2)
                    (inroom ?a ?r)
                    (inroom Table2 ?r)
                    (available ?a)
                    (handempty ?a)
                    (forall (?a2 - agent) (not (pickup-table-2 ?a2 ?b ?r)))
                )
    :effect (and
                (not (on-table ?b Table2))
                (not (handempty ?a))
                (holding ?a ?b)
            )
)
(:action putdown-table-2
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (inroom ?a ?r)
                    (inroom Table2 ?r)
                    (available ?a)
                    (holding ?a ?b)
                    ; check table not lifted
                    (forall (?s - side2)
                        (down ?s)
                    )
                    ; check table not intended to be lifted!
                    (forall (?a2 - agent ?s - side2) (not (lift-side-2 ?a2 ?s)))
                )
	:effect	(and
                    (on-table ?b Table2)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
)

(:action to-table-2
    :agent ?a - agent
	:parameters (?r - room ?s - side2)
	:precondition (and
                    (clear ?s)
                    (inroom ?a ?r)
                    (inroom Table2 ?r)
                    (available ?a)
                    (forall (?a2 - agent) (not (to-table-2 ?a2 ?r ?s)))
                )
	:effect	(and
                (not (clear ?s))
                (at-side ?a ?s)
                (not (available ?a))
            )
)
(:action leave-table-2
    :agent ?a - agent
    :parameters (?s - side2)
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

(:action move-table-2
    :agent ?a - agent
    :parameters (?r1 ?r2 - room ?s - side2)
    :precondition (and
                    (lifting ?a ?s)
                    (inroom ?a ?r1)
                    (connected ?r1 ?r2)
                    (exists (?a2 - agent ?s2 - side2)
                        (and
                            (not (= ?s ?s2))
                            (move-table-2 ?a2 ?r1 ?r2 ?s2)
                        )
                    )
                )
    :effect (and
                (not (inroom ?a ?r1))
                (not (inroom Table2 ?r1))
                (inroom ?a ?r2)
                (inroom Table2 ?r2)
            )
)

(:action lift-side-2
    :agent ?a - agent
    :parameters (?s - side2)
    :precondition (and
                    (down ?s)
                    (at-side ?a ?s)
                    (handempty ?a)
                    (forall (?a2 - agent ?s2 - side2)
                        (not (lower-side-2 ?a2 ?s2))
                    )
                )
    :effect (and
                (not (down ?s))
                (up ?s)
                (lifting ?a ?s)
                (not (handempty ?a))
                (forall (?b - block ?r - room ?s2 - side2)
                        (when (and
                                (inroom Table2 ?r)
                                (on-table ?b Table2)
                                (down ?s2)
                                (forall (?a2 - agent)
                                        (not (lift-side-2 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table2))
                            )
                        )
                )
	)
)

(:action lower-side-2
    :agent ?a - agent
    :parameters (?s - side2)
    :precondition (and
                    (lifting ?a ?s)
                    (forall (?a2 - agent ?s2 - side2)
                        (not (lift-side-2 ?a2 ?s2))
                    )
                )
    :effect (and
                (down ?s)
                (not (up ?s))
                (not (lifting ?a ?s))
                (handempty ?a)
                (forall (?b - block ?r - room ?s2 - side2)
                        (when (and
                                (inroom Table2 ?r)
                                (on-table ?b Table2)
                                (up ?s2)
                                (forall (?a2 - agent)
                                    (not (lower-side-2 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table2))
                            )
                        )
                )
        )
)

(:action pickup-table-3
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (on-table ?b Table3)
                    (inroom ?a ?r)
                    (inroom Table3 ?r)
                    (available ?a)
                    (handempty ?a)
                    (forall (?a2 - agent) (not (pickup-table-3 ?a2 ?b ?r)))
                )
    :effect (and
                (not (on-table ?b Table3))
                (not (handempty ?a))
                (holding ?a ?b)
            )
)
(:action putdown-table-3
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (inroom ?a ?r)
                    (inroom Table3 ?r)
                    (available ?a)
                    (holding ?a ?b)
                    ; check table not lifted
                    (forall (?s - side3)
                        (down ?s)
                    )
                    ; check table not intended to be lifted!
                    (forall (?a2 - agent ?s - side3) (not (lift-side-3 ?a2 ?s)))
                )
	:effect	(and
                    (on-table ?b Table3)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
)

(:action to-table-3
    :agent ?a - agent
	:parameters (?r - room ?s - side3)
	:precondition (and
                    (clear ?s)
                    (inroom ?a ?r)
                    (inroom Table3 ?r)
                    (available ?a)
                    (forall (?a2 - agent) (not (to-table-3 ?a2 ?r ?s)))
                )
	:effect	(and
                (not (clear ?s))
                (at-side ?a ?s)
                (not (available ?a))
            )
)
(:action leave-table-3
    :agent ?a - agent
    :parameters (?s - side3)
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

(:action move-table-3
    :agent ?a - agent
    :parameters (?r1 ?r2 - room ?s - side3)
    :precondition (and
                    (lifting ?a ?s)
                    (inroom ?a ?r1)
                    (connected ?r1 ?r2)
                    (exists (?a2 - agent ?s2 - side3)
                        (and
                            (not (= ?s ?s2))
                            (move-table-3 ?a2 ?r1 ?r2 ?s2)
                        )
                    )
                )
    :effect (and
                (not (inroom ?a ?r1))
                (not (inroom Table3 ?r1))
                (inroom ?a ?r2)
                (inroom Table3 ?r2)
            )
)

(:action lift-side-3
    :agent ?a - agent
    :parameters (?s - side3)
    :precondition (and
                    (down ?s)
                    (at-side ?a ?s)
                    (handempty ?a)
                    (forall (?a2 - agent ?s2 - side3)
                        (not (lower-side-3 ?a2 ?s2))
                    )
                )
    :effect (and
                (not (down ?s))
                (up ?s)
                (lifting ?a ?s)
                (not (handempty ?a))
                (forall (?b - block ?r - room ?s2 - side3)
                        (when (and
                                (inroom Table3 ?r)
                                (on-table ?b Table3)
                                (down ?s2)
                                (forall (?a2 - agent)
                                        (not (lift-side-3 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table3))
                            )
                        )
                )
	)
)

(:action lower-side-3
    :agent ?a - agent
    :parameters (?s - side3)
    :precondition (and
                    (lifting ?a ?s)
                    (forall (?a2 - agent ?s2 - side3)
                        (not (lift-side-3 ?a2 ?s2))
                    )
                )
    :effect (and
                (down ?s)
                (not (up ?s))
                (not (lifting ?a ?s))
                (handempty ?a)
                (forall (?b - block ?r - room ?s2 - side3)
                        (when (and
                                (inroom Table3 ?r)
                                (on-table ?b Table3)
                                (up ?s2)
                                (forall (?a2 - agent)
                                    (not (lower-side-3 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table3))
                            )
                        )
                )
        )
)

(:action pickup-table-4
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (on-table ?b Table4)
                    (inroom ?a ?r)
                    (inroom Table4 ?r)
                    (available ?a)
                    (handempty ?a)
                    (forall (?a2 - agent) (not (pickup-table-4 ?a2 ?b ?r)))
                )
    :effect (and
                (not (on-table ?b Table4))
                (not (handempty ?a))
                (holding ?a ?b)
            )
)
(:action putdown-table-4
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (inroom ?a ?r)
                    (inroom Table4 ?r)
                    (available ?a)
                    (holding ?a ?b)
                    ; check table not lifted
                    (forall (?s - side4)
                        (down ?s)
                    )
                    ; check table not intended to be lifted!
                    (forall (?a2 - agent ?s - side4) (not (lift-side-4 ?a2 ?s)))
                )
	:effect	(and
                    (on-table ?b Table4)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
)

(:action to-table-4
    :agent ?a - agent
	:parameters (?r - room ?s - side4)
	:precondition (and
                    (clear ?s)
                    (inroom ?a ?r)
                    (inroom Table4 ?r)
                    (available ?a)
                    (forall (?a2 - agent) (not (to-table-4 ?a2 ?r ?s)))
                )
	:effect	(and
                (not (clear ?s))
                (at-side ?a ?s)
                (not (available ?a))
            )
)
(:action leave-table-4
    :agent ?a - agent
    :parameters (?s - side4)
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

(:action move-table-4
    :agent ?a - agent
    :parameters (?r1 ?r2 - room ?s - side4)
    :precondition (and
                    (lifting ?a ?s)
                    (inroom ?a ?r1)
                    (connected ?r1 ?r2)
                    (exists (?a2 - agent ?s2 - side4)
                        (and
                            (not (= ?s ?s2))
                            (move-table-4 ?a2 ?r1 ?r2 ?s2)
                        )
                    )
                )
    :effect (and
                (not (inroom ?a ?r1))
                (not (inroom Table4 ?r1))
                (inroom ?a ?r2)
                (inroom Table4 ?r2)
            )
)

(:action lift-side-4
    :agent ?a - agent
    :parameters (?s - side4)
    :precondition (and
                    (down ?s)
                    (at-side ?a ?s)
                    (handempty ?a)
                    (forall (?a2 - agent ?s2 - side4)
                        (not (lower-side-4 ?a2 ?s2))
                    )
                )
    :effect (and
                (not (down ?s))
                (up ?s)
                (lifting ?a ?s)
                (not (handempty ?a))
                (forall (?b - block ?r - room ?s2 - side4)
                        (when (and
                                (inroom Table4 ?r)
                                (on-table ?b Table4)
                                (down ?s2)
                                (forall (?a2 - agent)
                                        (not (lift-side-4 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table4))
                            )
                        )
                )
	)
)

(:action lower-side-4
    :agent ?a - agent
    :parameters (?s - side4)
    :precondition (and
                    (lifting ?a ?s)
                    (forall (?a2 - agent ?s2 - side4)
                        (not (lift-side-4 ?a2 ?s2))
                    )
                )
    :effect (and
                (down ?s)
                (not (up ?s))
                (not (lifting ?a ?s))
                (handempty ?a)
                (forall (?b - block ?r - room ?s2 - side4)
                        (when (and
                                (inroom Table4 ?r)
                                (on-table ?b Table4)
                                (up ?s2)
                                (forall (?a2 - agent)
                                    (not (lower-side-4 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table4))
                            )
                        )
                )
        )
)

(:action pickup-table-5
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (on-table ?b Table5)
                    (inroom ?a ?r)
                    (inroom Table5 ?r)
                    (available ?a)
                    (handempty ?a)
                    (forall (?a2 - agent) (not (pickup-table-5 ?a2 ?b ?r)))
                )
    :effect (and
                (not (on-table ?b Table5))
                (not (handempty ?a))
                (holding ?a ?b)
            )
)
(:action putdown-table-5
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (inroom ?a ?r)
                    (inroom Table5 ?r)
                    (available ?a)
                    (holding ?a ?b)
                    ; check table not lifted
                    (forall (?s - side5)
                        (down ?s)
                    )
                    ; check table not intended to be lifted!
                    (forall (?a2 - agent ?s - side5) (not (lift-side-5 ?a2 ?s)))
                )
	:effect	(and
                    (on-table ?b Table5)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
)

(:action to-table-5
    :agent ?a - agent
	:parameters (?r - room ?s - side5)
	:precondition (and
                    (clear ?s)
                    (inroom ?a ?r)
                    (inroom Table5 ?r)
                    (available ?a)
                    (forall (?a2 - agent) (not (to-table-5 ?a2 ?r ?s)))
                )
	:effect	(and
                (not (clear ?s))
                (at-side ?a ?s)
                (not (available ?a))
            )
)
(:action leave-table-5
    :agent ?a - agent
    :parameters (?s - side5)
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

(:action move-table-5
    :agent ?a - agent
    :parameters (?r1 ?r2 - room ?s - side5)
    :precondition (and
                    (lifting ?a ?s)
                    (inroom ?a ?r1)
                    (connected ?r1 ?r2)
                    (exists (?a2 - agent ?s2 - side5)
                        (and
                            (not (= ?s ?s2))
                            (move-table-5 ?a2 ?r1 ?r2 ?s2)
                        )
                    )
                )
    :effect (and
                (not (inroom ?a ?r1))
                (not (inroom Table5 ?r1))
                (inroom ?a ?r2)
                (inroom Table5 ?r2)
            )
)

(:action lift-side-5
    :agent ?a - agent
    :parameters (?s - side5)
    :precondition (and
                    (down ?s)
                    (at-side ?a ?s)
                    (handempty ?a)
                    (forall (?a2 - agent ?s2 - side5)
                        (not (lower-side-5 ?a2 ?s2))
                    )
                )
    :effect (and
                (not (down ?s))
                (up ?s)
                (lifting ?a ?s)
                (not (handempty ?a))
                (forall (?b - block ?r - room ?s2 - side5)
                        (when (and
                                (inroom Table5 ?r)
                                (on-table ?b Table5)
                                (down ?s2)
                                (forall (?a2 - agent)
                                        (not (lift-side-5 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table5))
                            )
                        )
                )
	)
)

(:action lower-side-5
    :agent ?a - agent
    :parameters (?s - side5)
    :precondition (and
                    (lifting ?a ?s)
                    (forall (?a2 - agent ?s2 - side5)
                        (not (lift-side-5 ?a2 ?s2))
                    )
                )
    :effect (and
                (down ?s)
                (not (up ?s))
                (not (lifting ?a ?s))
                (handempty ?a)
                (forall (?b - block ?r - room ?s2 - side5)
                        (when (and
                                (inroom Table5 ?r)
                                (on-table ?b Table5)
                                (up ?s2)
                                (forall (?a2 - agent)
                                    (not (lower-side-5 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table5))
                            )
                        )
                )
        )
)

(:action pickup-table-6
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (on-table ?b Table6)
                    (inroom ?a ?r)
                    (inroom Table6 ?r)
                    (available ?a)
                    (handempty ?a)
                    (forall (?a2 - agent) (not (pickup-table-6 ?a2 ?b ?r)))
                )
    :effect (and
                (not (on-table ?b Table6))
                (not (handempty ?a))
                (holding ?a ?b)
            )
)
(:action putdown-table-6
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (inroom ?a ?r)
                    (inroom Table6 ?r)
                    (available ?a)
                    (holding ?a ?b)
                    ; check table not lifted
                    (forall (?s - side6)
                        (down ?s)
                    )
                    ; check table not intended to be lifted!
                    (forall (?a2 - agent ?s - side6) (not (lift-side-6 ?a2 ?s)))
                )
	:effect	(and
                    (on-table ?b Table6)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
)

(:action to-table-6
    :agent ?a - agent
	:parameters (?r - room ?s - side6)
	:precondition (and
                    (clear ?s)
                    (inroom ?a ?r)
                    (inroom Table6 ?r)
                    (available ?a)
                    (forall (?a2 - agent) (not (to-table-6 ?a2 ?r ?s)))
                )
	:effect	(and
                (not (clear ?s))
                (at-side ?a ?s)
                (not (available ?a))
            )
)
(:action leave-table-6
    :agent ?a - agent
    :parameters (?s - side6)
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

(:action move-table-6
    :agent ?a - agent
    :parameters (?r1 ?r2 - room ?s - side6)
    :precondition (and
                    (lifting ?a ?s)
                    (inroom ?a ?r1)
                    (connected ?r1 ?r2)
                    (exists (?a2 - agent ?s2 - side6)
                        (and
                            (not (= ?s ?s2))
                            (move-table-6 ?a2 ?r1 ?r2 ?s2)
                        )
                    )
                )
    :effect (and
                (not (inroom ?a ?r1))
                (not (inroom Table6 ?r1))
                (inroom ?a ?r2)
                (inroom Table6 ?r2)
            )
)

(:action lift-side-6
    :agent ?a - agent
    :parameters (?s - side6)
    :precondition (and
                    (down ?s)
                    (at-side ?a ?s)
                    (handempty ?a)
                    (forall (?a2 - agent ?s2 - side6)
                        (not (lower-side-6 ?a2 ?s2))
                    )
                )
    :effect (and
                (not (down ?s))
                (up ?s)
                (lifting ?a ?s)
                (not (handempty ?a))
                (forall (?b - block ?r - room ?s2 - side6)
                        (when (and
                                (inroom Table6 ?r)
                                (on-table ?b Table6)
                                (down ?s2)
                                (forall (?a2 - agent)
                                        (not (lift-side-6 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table6))
                            )
                        )
                )
	)
)

(:action lower-side-6
    :agent ?a - agent
    :parameters (?s - side6)
    :precondition (and
                    (lifting ?a ?s)
                    (forall (?a2 - agent ?s2 - side6)
                        (not (lift-side-6 ?a2 ?s2))
                    )
                )
    :effect (and
                (down ?s)
                (not (up ?s))
                (not (lifting ?a ?s))
                (handempty ?a)
                (forall (?b - block ?r - room ?s2 - side6)
                        (when (and
                                (inroom Table6 ?r)
                                (on-table ?b Table6)
                                (up ?s2)
                                (forall (?a2 - agent)
                                    (not (lower-side-6 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table6))
                            )
                        )
                )
        )
)

(:action pickup-table-7
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (on-table ?b Table7)
                    (inroom ?a ?r)
                    (inroom Table7 ?r)
                    (available ?a)
                    (handempty ?a)
                    (forall (?a2 - agent) (not (pickup-table-7 ?a2 ?b ?r)))
                )
    :effect (and
                (not (on-table ?b Table7))
                (not (handempty ?a))
                (holding ?a ?b)
            )
)
(:action putdown-table-7
    :agent ?a - agent
    :parameters (?b - block ?r - room)
    :precondition (and
                    (inroom ?a ?r)
                    (inroom Table7 ?r)
                    (available ?a)
                    (holding ?a ?b)
                    ; check table not lifted
                    (forall (?s - side7)
                        (down ?s)
                    )
                    ; check table not intended to be lifted!
                    (forall (?a2 - agent ?s - side7) (not (lift-side-7 ?a2 ?s)))
                )
	:effect	(and
                    (on-table ?b Table7)
                    (handempty ?a)
                    (not (holding ?a ?b))
                )
)

(:action to-table-7
    :agent ?a - agent
	:parameters (?r - room ?s - side7)
	:precondition (and
                    (clear ?s)
                    (inroom ?a ?r)
                    (inroom Table7 ?r)
                    (available ?a)
                    (forall (?a2 - agent) (not (to-table-7 ?a2 ?r ?s)))
                )
	:effect	(and
                (not (clear ?s))
                (at-side ?a ?s)
                (not (available ?a))
            )
)
(:action leave-table-7
    :agent ?a - agent
    :parameters (?s - side7)
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

(:action move-table-7
    :agent ?a - agent
    :parameters (?r1 ?r2 - room ?s - side7)
    :precondition (and
                    (lifting ?a ?s)
                    (inroom ?a ?r1)
                    (connected ?r1 ?r2)
                    (exists (?a2 - agent ?s2 - side7)
                        (and
                            (not (= ?s ?s2))
                            (move-table-7 ?a2 ?r1 ?r2 ?s2)
                        )
                    )
                )
    :effect (and
                (not (inroom ?a ?r1))
                (not (inroom Table7 ?r1))
                (inroom ?a ?r2)
                (inroom Table7 ?r2)
            )
)

(:action lift-side-7
    :agent ?a - agent
    :parameters (?s - side7)
    :precondition (and
                    (down ?s)
                    (at-side ?a ?s)
                    (handempty ?a)
                    (forall (?a2 - agent ?s2 - side7)
                        (not (lower-side-7 ?a2 ?s2))
                    )
                )
    :effect (and
                (not (down ?s))
                (up ?s)
                (lifting ?a ?s)
                (not (handempty ?a))
                (forall (?b - block ?r - room ?s2 - side7)
                        (when (and
                                (inroom Table7 ?r)
                                (on-table ?b Table7)
                                (down ?s2)
                                (forall (?a2 - agent)
                                        (not (lift-side-7 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table7))
                            )
                        )
                )
	)
)

(:action lower-side-7
    :agent ?a - agent
    :parameters (?s - side7)
    :precondition (and
                    (lifting ?a ?s)
                    (forall (?a2 - agent ?s2 - side7)
                        (not (lift-side-7 ?a2 ?s2))
                    )
                )
    :effect (and
                (down ?s)
                (not (up ?s))
                (not (lifting ?a ?s))
                (handempty ?a)
                (forall (?b - block ?r - room ?s2 - side7)
                        (when (and
                                (inroom Table7 ?r)
                                (on-table ?b Table7)
                                (up ?s2)
                                (forall (?a2 - agent)
                                    (not (lower-side-7 ?a2 ?s2))
                                )
                            )
                            (and
                                (on-floor ?b)
                                (inroom ?b ?r)
                                (not (on-table ?b Table7))
                            )
                        )
                )
        )
)
)
