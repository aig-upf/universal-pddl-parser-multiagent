(define (problem table8_16_2_1) (:domain tablemover)
(:objects
	a0 - agent
	a1 - agent
	a2 - agent
	a3 - agent
	b0 - block
	b1 - block
	b2 - block
	b3 - block
	b4 - block
	b5 - block
	b6 - block
	b7 - block
	b8 - block
	b9 - block
	b10 - block
	b11 - block
	b12 - block
	b13 - block
	b14 - block
	b15 - block
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
	(on-floor b4)
	(on-floor b5)
	(on-floor b6)
	(on-floor b7)
	(on-floor b8)
	(on-floor b9)
	(on-floor b10)
	(on-floor b11)
	(on-floor b12)
	(on-floor b13)
	(on-floor b14)
	(on-floor b15)
	(inroom b0 r7)
	(inroom b1 r1)
	(inroom b2 r5)
	(inroom b3 r2)
	(inroom b4 r0)
	(inroom b5 r4)
	(inroom b6 r6)
	(inroom b7 r5)
	(inroom b8 r0)
	(inroom b9 r5)
	(inroom b10 r3)
	(inroom b11 r3)
	(inroom b12 r4)
	(inroom b13 r7)
	(inroom b14 r6)
	(inroom b15 r5)
	(inroom a0 r2)
	(inroom a1 r2)
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
	(connected r0 r4)
	(connected r4 r0)
	(connected r4 r3)
	(connected r3 r4)
	(connected r0 r1)
	(connected r1 r0)
	(connected r1 r5)
	(connected r5 r1)
	(connected r3 r7)
	(connected r7 r3)
	(connected r7 r6)
	(connected r6 r7)
	(connected r6 r2)
	(connected r2 r6)
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(clear left0)
	(clear right0)
	(clear left1)
	(clear right1)
	(inroom Table0 r2)
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
	(on-floor b4)
	(on-floor b5)
	(on-floor b6)
	(on-floor b7)
	(on-floor b8)
	(on-floor b9)
	(on-floor b10)
	(on-floor b11)
	(on-floor b12)
	(on-floor b13)
	(on-floor b14)
	(on-floor b15)
	(inroom b0 r4)
	(inroom b1 r4)
	(inroom b2 r4)
	(inroom b3 r4)
	(inroom b4 r4)
	(inroom b5 r4)
	(inroom b6 r4)
	(inroom b7 r4)
	(inroom b8 r4)
	(inroom b9 r4)
	(inroom b10 r4)
	(inroom b11 r4)
	(inroom b12 r4)
	(inroom b13 r4)
	(inroom b14 r4)
	(inroom b15 r4)
))
)
