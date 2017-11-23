(define (problem table16_2_1_1) (:domain tablemover)
(:objects
	a0 - agent
	a1 - agent
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
	(inroom b0 r4)
	(inroom b1 r6)
	(inroom a0 r0)
	(inroom a1 r0)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r14 r10)
	(connected r10 r14)
	(connected r10 r12)
	(connected r12 r10)
	(connected r12 r8)
	(connected r8 r12)
	(connected r8 r1)
	(connected r1 r8)
	(connected r1 r9)
	(connected r9 r1)
	(connected r9 r6)
	(connected r6 r9)
	(connected r6 r11)
	(connected r11 r6)
	(connected r10 r15)
	(connected r15 r10)
	(connected r15 r13)
	(connected r13 r15)
	(connected r6 r2)
	(connected r2 r6)
	(connected r2 r4)
	(connected r4 r2)
	(connected r6 r3)
	(connected r3 r6)
	(connected r3 r7)
	(connected r7 r3)
	(connected r8 r5)
	(connected r5 r8)
	(connected r13 r0)
	(connected r0 r13)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r0)
)
(:goal (and
	(down left0)
	(down right0)
	(on-floor b0)
	(on-floor b1)
	(inroom b0 r15)
	(inroom b1 r15)
))
)
