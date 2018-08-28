(define (domain tablemover)
(:requirements :typing :conditional-effects :multi-agent)
(:types agent block table - locatable
	side0 - side
	locatable room side
)
(:constants Table0 - table)
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
)
