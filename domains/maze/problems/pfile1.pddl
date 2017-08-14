(define (problem maze1) (:domain maze)
(:objects
	a1 a2 a3 - agent
	loc11 loc12 loc13 loc21 loc22 loc23 loc31 loc32 loc33 - location
	d1 d2 d3 d4 d5 d6 d7 - door
	b1 b2 - bridge
	bt1 bt2 - boat
	s1 s2 - switch
)
(:init
	(at a1 loc11)
	(at a2 loc13)
	(at a3 loc32)

	(has-door d1 loc11 loc12)
	(has-door d1 loc12 loc11)
	(has-door d2 loc12 loc13)
	(has-door d2 loc13 loc12)
	(has-door d3 loc31 loc32)
	(has-door d3 loc32 loc31)
	(has-door d4 loc11 loc21)
	(has-door d4 loc21 loc11)	
	(has-door d5 loc22 loc32)
	(has-door d5 loc32 loc22)
	(has-door d6 loc13 loc23)
	(has-door d6 loc23 loc13)
	(has-door d7 loc23 loc33)
	(has-door d7 loc33 loc23)

	(has-switch s1 loc33 loc13 loc12)
	(blocked loc13 loc12)
	(blocked loc12 loc13)
	(has-switch s2 loc21 loc22 loc32)
	(blocked loc22 loc32)
	(blocked loc32 loc22)

	(has-bridge b1 loc22 loc23)
	(has-bridge b1 loc23 loc22)
	(has-bridge b2 loc32 loc33)
	(has-bridge b2 loc33 loc32)

	(has-boat bt1 loc12 loc22)
	(has-boat bt1 loc22 loc12)
	(has-boat bt2 loc21 loc31)
	(has-boat bt2 loc31 loc21)	
)
(:goal
 (and
	(at a1 loc33)
	(at a2 loc31)
	(at a3 loc12)
 )
)
)
