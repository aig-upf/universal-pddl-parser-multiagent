(define (problem boxpushing_example) (:domain boxpushing)
(:objects
    a1 a2 a3 - agent
    r1 r2 - location
    b1 - largebox
)
(:init
    (at a1 r2)
    (at a2 r2)
    (at a3 r2)
    (at b1 r1)
    (connected r1 r2)
    (connected r2 r1)
)
(:goal (and
    (at a1 r1)
    (at b1 r2)
))
)
