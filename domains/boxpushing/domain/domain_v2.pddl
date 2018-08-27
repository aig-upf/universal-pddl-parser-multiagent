(define (domain boxpushing)
(:requirements :typing :multi-agent)
(:types largebox mediumbox smallbox - box 
        box agent - locatable
        location)
(:predicates
    (at ?l - locatable ?x - location)
    (different ?a1 ?a2 - agent)
    (connected ?x - location ?y - location)
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
(:action push-small
    :agent ?a - agent
    :parameters (?b - smallbox ?x - location ?y - location)
    :precondition (and
                    (at ?a ?x)
                    (at ?b ?x)
                    (connected ?x ?y)
                  )
    :effect	(and
                (at ?a ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?b ?x))
            )
)
(:action push-medium
    :agent ?a - agent
    :parameters (?a2 - agent ?b - mediumbox ?x - location ?y - location)
    :precondition (and
                    (at ?a ?x)
                    (at ?b ?x)
                    (connected ?x ?y)
                    (different ?a ?a2)
                    (push-medium ?a2 ?b ?x ?y)
                  )
    :effect	(and
                (at ?a ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?b ?x))
            )
)
(:action push-large
    :agent ?a - agent
    :parameters (?a2 ?a3 - agent ?b - largebox ?x - location ?y - location)
    :precondition (and
                    (at ?a ?x)
                    (at ?b ?x)
                    (connected ?x ?y)
                    (different ?a ?a2)
                    (different ?a ?a3)
                    (different ?a2 ?a3)
                    (push-large ?a2 ?b ?x ?y)
                    (push-large ?a3 ?b ?x ?y)
                  )
    :effect	(and
                (at ?a ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?b ?x))
            )
)
)
