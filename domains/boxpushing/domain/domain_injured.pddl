; variation of the original domain
(define (domain boxpushing)
(:requirements :typing :multi-agent)
(:types largebox mediumbox smallbox - box
        box agent - locatable
        location)
(:predicates
    (at ?l - locatable ?x - location)
    (connected ?x - location ?y - location)
    (injured ?a - agent)
)
(:action move
    :agent ?a - agent
    :parameters (?x - location ?y - location)
    :precondition (and
                    (at ?a ?x)
                    (connected ?x ?y)
                  )
    :effect	(and
                (at ?a ?y)
                (not (at ?a ?x))
            )
)
(:action push-alone
    :agent ?a - agent
    :parameters (?b - box ?x - location ?y - location)
    :precondition (and
                    (not (injured ?a))
                    (at ?a ?x)
                    (at ?b ?x)
                    (connected ?x ?y)
                  )
    :effect	(and
                (at ?a ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?b ?x))
                (injured ?a)
            )
)
(:action push-together
    :agent ?a - agent
    :parameters (?b - box ?x - location ?y - location)
    :precondition (and
                    (not (injured ?a))
                    (at ?a ?x)
                    (at ?b ?x)
                    (connected ?x ?y)
                    (exists (?a2 - agent)
                            (and
                                (not (= ?a ?a2))
                                (push-together ?a2 ?b ?x ?y)
                            )
                    )
                  )
    :effect	(and
                (at ?a ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?b ?x))
            )
)
)
