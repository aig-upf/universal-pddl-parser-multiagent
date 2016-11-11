(define (problem table1_1) (:domain tablemover)
(:objects
	a1 a2 - agent
	b1 - block
	r1x1 r1x2 - room
	left1 right1 - side
)
(:init
	(on-floor b1)
	(down left1)
	(down right1)
	(clear left1)
	(clear right1)
	(inroom a1 r1x1)
	(inroom a2 r1x1)
	(inroom b1 r1x1)
	(inroom Table r1x1)
	(available a1)
	(available a2)
	(handempty a1)
	(handempty a2)
	(connected r1x1 r1x2)
)
(:goal (and
	(on-floor b1)
	(down left1)
	(down right1)
	(inroom b1 r1x2)
))
)
