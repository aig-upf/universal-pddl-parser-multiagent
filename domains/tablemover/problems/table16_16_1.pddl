(define (problem table16_16_1_1) (:domain tablemover)
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
	r8 - room
	r9 - room
	r10 - room
	r11 - room
	r12 - room
	r13 - room
	r14 - room
	r15 - room
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
	(inroom b0 r14)
	(inroom b1 r15)
	(inroom b2 r14)
	(inroom b3 r13)
	(inroom b4 r9)
	(inroom b5 r2)
	(inroom b6 r13)
	(inroom b7 r2)
	(inroom b8 r14)
	(inroom b9 r3)
	(inroom b10 r1)
	(inroom b11 r5)
	(inroom b12 r13)
	(inroom b13 r14)
	(inroom b14 r5)
	(inroom b15 r13)
	(inroom a0 r13)
	(inroom a1 r13)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r11 r7)
	(connected r7 r11)
	(connected r7 r1)
	(connected r1 r7)
	(connected r1 r12)
	(connected r12 r1)
	(connected r12 r6)
	(connected r6 r12)
	(connected r6 r4)
	(connected r4 r6)
	(connected r4 r5)
	(connected r5 r4)
	(connected r5 r2)
	(connected r2 r5)
	(connected r6 r13)
	(connected r13 r6)
	(connected r13 r3)
	(connected r3 r13)
	(connected r1 r8)
	(connected r8 r1)
	(connected r8 r9)
	(connected r9 r8)
	(connected r2 r14)
	(connected r14 r2)
	(connected r9 r0)
	(connected r0 r9)
	(connected r0 r10)
	(connected r10 r0)
	(connected r8 r15)
	(connected r15 r8)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r13)
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
	(inroom b0 r14)
	(inroom b1 r14)
	(inroom b2 r14)
	(inroom b3 r14)
	(inroom b4 r14)
	(inroom b5 r14)
	(inroom b6 r14)
	(inroom b7 r14)
	(inroom b8 r14)
	(inroom b9 r14)
	(inroom b10 r14)
	(inroom b11 r14)
	(inroom b12 r14)
	(inroom b13 r14)
	(inroom b14 r14)
	(inroom b15 r14)
))
)
