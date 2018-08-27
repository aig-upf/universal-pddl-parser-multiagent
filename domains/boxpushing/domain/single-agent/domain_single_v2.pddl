(define (domain boxpushing)
(:requirements :typing :equality)
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
    :parameters (?a - agent ?b - mediumbox ?x - location ?y - location ?a2 - agent ?b2 - mediumbox ?x2 - location ?y2 - location)
    :precondition (and
                    (not (= ?a ?a2))
                    (= ?b ?b2)
                    (= ?x ?x2)
                    (= ?y ?y2)

                    (at ?a ?x)
                    (at ?b ?x)
                    (connected ?x ?y)

                    (at ?a2 ?x2)
                    (at ?b2 ?x2)
                    (connected ?x2 ?y2)
                  )
    :effect	(and
                (at ?a ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?b ?x))

                (at ?a2 ?y2)
                (at ?b2 ?y2)
                (not (at ?a2 ?x2))
                (not (at ?b2 ?x2))
            )
)
(:action push-large
    :parameters (?a - agent ?b - largebox ?x - location ?y - location ?a2 - agent ?b2 - largebox ?x2 - location ?y2 - location ?a3 - agent ?b3 - largebox ?x3 - location ?y3 - location)
    :precondition (and
                    (not (= ?a ?a3))
                    (= ?b ?b3)
                    (= ?x ?x3)
                    (= ?y ?y3)

                    (not (= ?a2 ?a3))
                    (= ?b2 ?b3)
                    (= ?x2 ?x3)
                    (= ?y2 ?y3)

                    (at ?a ?x)
                    (at ?b ?x)
                    (connected ?x ?y)

                    (at ?a2 ?x2)
                    (at ?b2 ?x2)
                    (connected ?x2 ?y2)

                    (at ?a3 ?x3)
                    (at ?b3 ?x3)
                    (connected ?x3 ?y3)
                  )
    :effect	(and
                (at ?a ?y)
                (at ?b ?y)
                (not (at ?a ?x))
                (not (at ?b ?x))

                (at ?a2 ?y2)
                (at ?b2 ?y2)
                (not (at ?a2 ?x2))
                (not (at ?b2 ?x2))

                (at ?a3 ?y3)
                (at ?b3 ?y3)
                (not (at ?a3 ?x3))
                (not (at ?b3 ?x3))
            )
)
)
