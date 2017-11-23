(define (problem table8_4_2_1) (:domain tablemover)
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
	r4 - room
	r5 - room
	r6 - room
	r7 - room
	left0 right0 - side0
	left1 right1 - side1
)
(:init
	(on-floor b0)
	(on-floor b1)
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r5)
	(inroom b1 r1)
	(inroom b2 r5)
	(inroom b3 r3)
	(inroom a0 r7)
	(inroom a1 r7)
	(inroom a2 r4)
	(inroom a3 r4)
	(available a0)
	(available a1)
	(available a2)
	(available a3)
	(handempty a0)
	(handempty a1)
	(handempty a2)
	(handempty a3)
	(connected r6 r1)
	(connected r1 r6)
	(connected r6 r2)
	(connected r2 r6)
	(connected r2 r7)
	(connected r7 r2)
	(connected r6 r0)
	(connected r0 r6)
	(connected r0 r4)
	(connected r4 r0)
	(connected r4 r5)
	(connected r5 r4)
	(connected r7 r3)
	(connected r3 r7)
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(clear left0)
	(clear right0)
	(clear left1)
	(clear right1)
	(inroom Table0 r7)
	(inroom Table1 r4)
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
	(inroom b0 r5)
	(inroom b1 r5)
	(inroom b2 r5)
	(inroom b3 r5)
))
)
