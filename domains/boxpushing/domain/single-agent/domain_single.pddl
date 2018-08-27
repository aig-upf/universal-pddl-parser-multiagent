(define (domain boxpushing)
(:requirements :typing)
(:types largebox mediumbox smallbox - box
        box agent - locatable
        location)
(:predicates
    (at ?l - locatable ?x - location)
    (connected ?x - location ?y - location)
)
(:action move
    :parameters (?a - agent ?x - location ?y - location)
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
    :parameters (?a - agent ?b - smallbox ?x - location ?y - location)
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
    :parameters (?a ?a2 - agent ?b - mediumbox ?x - location ?y - location)
    :precondition (and
                    (at ?a ?x)
                    (at ?a2 ?x)
                    (at ?b ?x)
                    (connected ?x ?y)
                  )
    :effect	(and
                (at ?a ?y)
                (at ?a2 ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?a2 ?x))
                (not (at ?b ?x))
            )
)
(:action push-large
    :parameters (?a ?a2 ?a3 - agent ?b - largebox ?x - location ?y - location)
    :precondition (and
                    (at ?a ?x)
                    (at ?a2 ?x)
                    (at ?a3 ?x)
                    (at ?b ?x)
                    (connected ?x ?y)
                  )
    :effect	(and
                (at ?a ?y)
                (at ?a2 ?y)
                (at ?a3 ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?a2 ?x))
                (not (at ?a3 ?x))
                (not (at ?b ?x))
            )
)
)
