(define (domain doorway)
(:requirements :typing :multi-agent)
(:types heavybox lightbox - box
        box agent - locatable
        location)
(:predicates
    (at ?l - locatable ?x - location)
    (lifting ?a - agent ?b - box)
    (handsempty ?a - agent)
    (connected ?x - location ?y - location)
)
(:action hold-door
    :agent ?a - agent
    :parameters (?x - location ?y - location)
    :precondition (and
                    (connected ?x ?y)
                    (at ?a ?x)
                  )
    :effect ()
)
(:action pick-light
    :agent ?a - agent
    :parameters (?b - lightbox ?x - location)
    :precondition (and
                    (handsempty ?a)
                    (at ?a ?x)
                    (at ?b ?x)
                    (forall (?a2 - agent)
                            (not (pick-light ?a2 ?b ?x))
                    )
                  )
    :effect (and
                (not (at ?b ?x))
                (not (handsempty ?a))
                (lifting ?a ?b)
            )
)
(:action pick-heavy
    :agent ?a - agent
    :parameters (?b - heavybox ?x - location)
    :precondition (and
                    (handsempty ?a)
                    (at ?a ?x)
                    (at ?b ?x)
                    (exists (?a2 - agent)
                            (and
                                (not (= ?a ?a2))
                                (pick-heavy ?a2 ?b ?x)
                            )
                    )
                  )
    :effect (and
                (not (at ?b ?x))
                (not (handsempty ?a))
                (lifting ?a ?b)
            )
)
(:action putdown-light
    :agent ?a - agent
    :parameters (?b - lightbox ?x - location)
    :precondition (and
                    (at ?a ?x)
                    (lifting ?a ?b)
                  )
    :effect (and
                (at ?b ?x)
                (handsempty ?a)
                (not (lifting ?a ?b))
            )
)
(:action putdown-heavy
    :agent ?a - agent
    :parameters (?b - heavybox ?x - location)
    :precondition (and
                    (lifting ?a ?b)
                    (at ?a ?x)
                    (exists (?a2 - agent)
                            (and
                                (not (= ?a ?a2))
                                (putdown-heavy ?a2 ?b ?x)
                            )
                    )
                  )
    :effect (and
                (at ?b ?x)
                (handsempty ?a)
                (not (lifting ?a ?b))
            )
)
(:action move-light
    :agent ?a - agent
    :parameters (?b - lightbox ?x - location ?y - location)
    :precondition (and
                    (lifting ?a ?b)
                    (at ?a ?x)
                    (exists (?a2 - agent)
                            (hold-door ?a2 ?x ?y)
                    )
                    (connected ?x ?y)
                  )
    :effect (and
                (not (at ?a ?x))
                (at ?a ?y)
            )
)
(:action move-heavy
    :agent ?a - agent
    :parameters (?b - heavybox ?x - location ?y - location)
    :precondition (and
                    (lifting ?a ?b)
                    (at ?a ?x)
                    (exists (?a2 - agent)
                                (hold-door ?a2 ?x ?y)
                    )
                    (exists (?a3 - agent)
                            (and
                                (not (= ?a ?a3))
                                (move-heavy ?a3 ?b ?x ?y)
                            )
                    )
                    (connected ?x ?y)
                  )
    :effect (and
                (not (at ?a ?x))
                (at ?a ?y)
            )
)
(:action move
    :agent ?a - agent
    :parameters (?x - location ?y - location)
    :precondition (and
                    (handsempty ?a)
                    (connected ?x ?y)
                    (at ?a ?x)
                  )
    :effect (and
                (not (at ?a ?x))
                (at ?a ?y)
            )
)
)
