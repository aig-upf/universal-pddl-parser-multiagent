(define (problem p1_3_2_2_1_0) (:domain boxpushing)
(:objects
	a1 a2 - agent
	s1 s2 - smallbox
	m1 - mediumbox
	r1x1 r1x2 r1x3 - location
)
(:init
	(at a1 r1x2)
	(at a2 r1x2)
	(at s1 r1x3)
	(at s2 r1x3)
	(at m1 r1x1)
	(connected r1x1 r1x2)
	(connected r1x2 r1x1)
	(connected r1x2 r1x3)
	(connected r1x3 r1x2)
)
(:goal (and
	(at a1 r1x3)
	(at a2 r1x1)
	(at s1 r1x2)
	(at s2 r1x1)
	(at m1 r1x3)
))
)
