(define (problem table8_16_1_1) (:domain tablemover)
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
	r4 - room
	r5 - room
	r6 - room
	r7 - room
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
	(inroom b0 r0)
	(inroom b1 r5)
	(inroom b2 r5)
	(inroom b3 r1)
	(inroom b4 r3)
	(inroom b5 r4)
	(inroom b6 r3)
	(inroom b7 r1)
	(inroom b8 r2)
	(inroom b9 r0)
	(inroom b10 r3)
	(inroom b11 r0)
	(inroom b12 r1)
	(inroom b13 r5)
	(inroom b14 r2)
	(inroom b15 r7)
	(inroom a0 r6)
	(inroom a1 r6)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r1 r0)
	(connected r0 r1)
	(connected r0 r4)
	(connected r4 r0)
	(connected r0 r2)
	(connected r2 r0)
	(connected r1 r3)
	(connected r3 r1)
	(connected r3 r7)
	(connected r7 r3)
	(connected r7 r5)
	(connected r5 r7)
	(connected r2 r6)
	(connected r6 r2)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r6)
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
	(inroom b0 r5)
	(inroom b1 r5)
	(inroom b2 r5)
	(inroom b3 r5)
	(inroom b4 r5)
	(inroom b5 r5)
	(inroom b6 r5)
	(inroom b7 r5)
	(inroom b8 r5)
	(inroom b9 r5)
	(inroom b10 r5)
	(inroom b11 r5)
	(inroom b12 r5)
	(inroom b13 r5)
	(inroom b14 r5)
	(inroom b15 r5)
))
)
