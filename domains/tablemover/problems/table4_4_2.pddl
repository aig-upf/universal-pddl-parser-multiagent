(define (problem table4_4_2_1) (:domain tablemover)
(:objects
	a0 - agent
	a1 - agent
	a2 - agent
	a3 - agent
	b0 - block
	b1 - block
	b2 - block
	b3 - block
	r0 - room
	r1 - room
	r2 - room
	r3 - room
	left0 right0 - side0
	left1 right1 - side1
)
(:init
	(on-floor b0)
	(on-floor b1)
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r1)
	(inroom b1 r2)
	(inroom b2 r2)
	(inroom b3 r3)
	(inroom a0 r1)
	(inroom a1 r1)
	(inroom a2 r3)
	(inroom a3 r3)
	(available a0)
	(available a1)
	(available a2)
	(available a3)
	(handempty a0)
	(handempty a1)
	(handempty a2)
	(handempty a3)
	(connected r2 r1)
	(connected r1 r2)
	(connected r1 r3)
	(connected r3 r1)
	(connected r2 r0)
	(connected r0 r2)
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(clear left0)
	(clear right0)
	(clear left1)
	(clear right1)
	(inroom Table0 r1)
	(inroom Table1 r3)
)
(:goal (and
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(on-floor b0)
	(on-floor b1)
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r0)
	(inroom b1 r0)
	(inroom b2 r0)
	(inroom b3 r0)
))
)
