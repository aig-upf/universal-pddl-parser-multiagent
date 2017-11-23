(define (problem table4_4_1_1) (:domain tablemover)
(:objects
	a0 - agent
	a1 - agent
	b0 - block
	b1 - block
	b2 - block
	b3 - block
	r0 - room
	r1 - room
	r2 - room
	r3 - room
	left0 right0 - side0
)
(:init
	(on-floor b0)
	(on-floor b1)
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r1)
	(inroom b1 r0)
	(inroom b2 r1)
	(inroom b3 r1)
	(inroom a0 r3)
	(inroom a1 r3)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r1 r2)
	(connected r2 r1)
	(connected r2 r0)
	(connected r0 r2)
	(connected r2 r3)
	(connected r3 r2)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r3)
)
(:goal (and
	(down left0)
	(down right0)
	(on-floor b0)
	(on-floor b1)
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r1)
	(inroom b1 r1)
	(inroom b2 r1)
	(inroom b3 r1)
))
)
