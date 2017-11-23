(define (problem table16_8_1_1) (:domain tablemover)
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
	(inroom b0 r12)
	(inroom b1 r3)
	(inroom b2 r8)
	(inroom b3 r1)
	(inroom b4 r4)
	(inroom b5 r6)
	(inroom b6 r8)
	(inroom b7 r9)
	(inroom a0 r15)
	(inroom a1 r15)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r13 r8)
	(connected r8 r13)
	(connected r8 r9)
	(connected r9 r8)
	(connected r9 r0)
	(connected r0 r9)
	(connected r0 r15)
	(connected r15 r0)
	(connected r15 r1)
	(connected r1 r15)
	(connected r0 r2)
	(connected r2 r0)
	(connected r13 r5)
	(connected r5 r13)
	(connected r5 r14)
	(connected r14 r5)
	(connected r5 r7)
	(connected r7 r5)
	(connected r7 r12)
	(connected r12 r7)
	(connected r15 r10)
	(connected r10 r15)
	(connected r10 r4)
	(connected r4 r10)
	(connected r2 r11)
	(connected r11 r2)
	(connected r9 r3)
	(connected r3 r9)
	(connected r10 r6)
	(connected r6 r10)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r15)
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
	(inroom b0 r1)
	(inroom b1 r1)
	(inroom b2 r1)
	(inroom b3 r1)
	(inroom b4 r1)
	(inroom b5 r1)
	(inroom b6 r1)
	(inroom b7 r1)
))
)
