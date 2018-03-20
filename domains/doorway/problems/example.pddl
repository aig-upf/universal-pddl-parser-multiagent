(define (problem p1) (:domain doorway)
(:objects
	a1 a2 a3 - agent
	l1 - heavybox
	r1 r2 - location
)
(:init
	(at a1 r1)
	(at a2 r1)
    (at a3 r1)
	(at l1 r1)
	(connected r1 r2)
	(connected r2 r1)
    (handsempty a1)
    (handsempty a2)
    (handsempty a3)
)
(:goal (and
    (at l1 r2)
))
)
