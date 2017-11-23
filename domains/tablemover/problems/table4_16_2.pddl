(define (problem table4_16_2_1) (:domain tablemover)
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
	(inroom b0 r3)
	(inroom b1 r0)
	(inroom b2 r2)
	(inroom b3 r0)
	(inroom b4 r1)
	(inroom b5 r3)
	(inroom b6 r2)
	(inroom b7 r1)
	(inroom b8 r1)
	(inroom b9 r2)
	(inroom b10 r2)
	(inroom b11 r3)
	(inroom b12 r1)
	(inroom b13 r1)
	(inroom b14 r2)
	(inroom b15 r3)
	(inroom a0 r0)
	(inroom a1 r0)
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
	(connected r2 r0)
	(connected r0 r2)
	(connected r2 r1)
	(connected r1 r2)
	(connected r1 r3)
	(connected r3 r1)
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(clear left0)
	(clear right0)
	(clear left1)
	(clear right1)
	(inroom Table0 r0)
	(inroom Table1 r2)
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
	(inroom b0 r3)
	(inroom b1 r3)
	(inroom b2 r3)
	(inroom b3 r3)
	(inroom b4 r3)
	(inroom b5 r3)
	(inroom b6 r3)
	(inroom b7 r3)
	(inroom b8 r3)
	(inroom b9 r3)
	(inroom b10 r3)
	(inroom b11 r3)
	(inroom b12 r3)
	(inroom b13 r3)
	(inroom b14 r3)
	(inroom b15 r3)
))
)
