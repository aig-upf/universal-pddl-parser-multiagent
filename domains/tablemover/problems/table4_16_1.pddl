(define (problem table4_16_1_1) (:domain tablemover)
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
	(inroom b0 r2)
	(inroom b1 r2)
	(inroom b2 r3)
	(inroom b3 r0)
	(inroom b4 r0)
	(inroom b5 r0)
	(inroom b6 r2)
	(inroom b7 r2)
	(inroom b8 r3)
	(inroom b9 r2)
	(inroom b10 r1)
	(inroom b11 r0)
	(inroom b12 r2)
	(inroom b13 r1)
	(inroom b14 r1)
	(inroom b15 r2)
	(inroom a0 r1)
	(inroom a1 r1)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r3 r1)
	(connected r1 r3)
	(connected r1 r2)
	(connected r2 r1)
	(connected r3 r0)
	(connected r0 r3)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r1)
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
	(on-floor b8)
	(on-floor b9)
	(on-floor b10)
	(on-floor b11)
	(on-floor b12)
	(on-floor b13)
	(on-floor b14)
	(on-floor b15)
	(inroom b0 r0)
	(inroom b1 r0)
	(inroom b2 r0)
	(inroom b3 r0)
	(inroom b4 r0)
	(inroom b5 r0)
	(inroom b6 r0)
	(inroom b7 r0)
	(inroom b8 r0)
	(inroom b9 r0)
	(inroom b10 r0)
	(inroom b11 r0)
	(inroom b12 r0)
	(inroom b13 r0)
	(inroom b14 r0)
	(inroom b15 r0)
))
)
