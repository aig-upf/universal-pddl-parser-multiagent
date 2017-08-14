(define (problem maze1) (:domain maze)
(:objects
	a1 a2 - agent
	loc11 loc12 - location
	bt1 - boat
)
(:init
	(at a1 loc11)
	(at a2 loc11)

	(has-boat bt1 loc11 loc12)
	(has-boat bt1 loc12 loc11)
)
(:goal
 (and
	(at a1 loc12)
	(at a2 loc12)
 )
)
)
