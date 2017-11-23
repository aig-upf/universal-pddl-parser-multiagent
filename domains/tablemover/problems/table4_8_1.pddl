(define (problem table4_8_1_1) (:domain tablemover)
(:objects
	a0 - agent
	a1 - agent
	b0 - block
	b1 - block
	b2 - block
	b3 - block
	b4 - block
	b5 - block
	b6 - block
	b7 - block
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
	(on-floor b4)
	(on-floor b5)
	(on-floor b6)
	(on-floor b7)
	(inroom b0 r0)
	(inroom b1 r0)
	(inroom b2 r3)
	(inroom b3 r0)
	(inroom b4 r2)
	(inroom b5 r3)
	(inroom b6 r0)
	(inroom b7 r3)
	(inroom a0 r3)
	(inroom a1 r3)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r3 r2)
	(connected r2 r3)
	(connected r2 r0)
	(connected r0 r2)
	(connected r0 r1)
	(connected r1 r0)
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
	(on-floor b4)
	(on-floor b5)
	(on-floor b6)
	(on-floor b7)
	(inroom b0 r0)
	(inroom b1 r0)
	(inroom b2 r0)
	(inroom b3 r0)
	(inroom b4 r0)
	(inroom b5 r0)
	(inroom b6 r0)
	(inroom b7 r0)
))
)
