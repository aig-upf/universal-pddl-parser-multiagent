(define (problem table16_4_1_1) (:domain tablemover)
(:objects
	a0 - agent
	a1 - agent
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
	(inroom b0 r5)
	(inroom b1 r14)
	(inroom b2 r13)
	(inroom b3 r7)
	(inroom a0 r9)
	(inroom a1 r9)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r13 r12)
	(connected r12 r13)
	(connected r12 r6)
	(connected r6 r12)
	(connected r6 r0)
	(connected r0 r6)
	(connected r0 r11)
	(connected r11 r0)
	(connected r11 r8)
	(connected r8 r11)
	(connected r8 r4)
	(connected r4 r8)
	(connected r4 r7)
	(connected r7 r4)
	(connected r7 r2)
	(connected r2 r7)
	(connected r2 r3)
	(connected r3 r2)
	(connected r3 r9)
	(connected r9 r3)
	(connected r6 r5)
	(connected r5 r6)
	(connected r4 r10)
	(connected r10 r4)
	(connected r2 r1)
	(connected r1 r2)
	(connected r10 r15)
	(connected r15 r10)
	(connected r4 r14)
	(connected r14 r4)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r9)
)
(:goal (and
	(down left0)
	(down right0)
	(on-floor b0)
	(on-floor b1)
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r14)
	(inroom b1 r14)
	(inroom b2 r14)
	(inroom b3 r14)
))
)
