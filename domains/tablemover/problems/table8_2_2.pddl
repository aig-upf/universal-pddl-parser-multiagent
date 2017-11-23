(define (problem table8_2_2_1) (:domain tablemover)
(:objects
	a0 - agent
	a1 - agent
	a2 - agent
	a3 - agent
	b0 - block
	b1 - block
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
	(inroom b0 r1)
	(inroom b1 r4)
	(inroom a0 r7)
	(inroom a1 r7)
	(inroom a2 r2)
	(inroom a3 r2)
	(available a0)
	(available a1)
	(available a2)
	(available a3)
	(handempty a0)
	(handempty a1)
	(handempty a2)
	(handempty a3)
	(connected r0 r7)
	(connected r7 r0)
	(connected r7 r4)
	(connected r4 r7)
	(connected r4 r3)
	(connected r3 r4)
	(connected r4 r5)
	(connected r5 r4)
	(connected r5 r6)
	(connected r6 r5)
	(connected r0 r2)
	(connected r2 r0)
	(connected r4 r1)
	(connected r1 r4)
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(clear left0)
	(clear right0)
	(clear left1)
	(clear right1)
	(inroom Table0 r7)
	(inroom Table1 r2)
)
(:goal (and
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(on-floor b0)
	(on-floor b1)
	(inroom b0 r3)
	(inroom b1 r3)
))
)
