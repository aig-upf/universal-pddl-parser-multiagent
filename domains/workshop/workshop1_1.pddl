(define (problem workshop1_1) (:domain workshop)
(:objects
	a1 a2 - agent
	f1 - forklift
	k1 - key
	p1 - pallet
	s1 - switch
	r1x1 r1x2 - room
	d1 - door
)
(:init
	(inroom a1 r1x1)
	(inroom a2 r1x1)
	(inroom f1 r1x1)
	(inroom k1 r1x1)
	(inroom p1 r1x2)
	(inroom s1 r1x1)
	(empty f1)
	(locked d1)
	(fits k1 d1)
	(connected s1 d1)
	(adjacent r1x1 r1x2 d1)
)
(:goal (and
	(examined p1)
))
)
