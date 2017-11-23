(define (problem table16_4_2_1) (:domain tablemover)
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
	r8 - room
	r9 - room
	r10 - room
	r11 - room
	r12 - room
	r13 - room
	r14 - room
	r15 - room
	left0 right0 - side0
	left1 right1 - side1
)
(:init
	(on-floor b0)
	(on-floor b1)
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r2)
	(inroom b1 r10)
	(inroom b2 r11)
	(inroom b3 r10)
	(inroom a0 r6)
	(inroom a1 r6)
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
	(connected r1 r0)
	(connected r0 r1)
	(connected r0 r8)
	(connected r8 r0)
	(connected r8 r3)
	(connected r3 r8)
	(connected r3 r13)
	(connected r13 r3)
	(connected r1 r6)
	(connected r6 r1)
	(connected r6 r10)
	(connected r10 r6)
	(connected r10 r7)
	(connected r7 r10)
	(connected r7 r2)
	(connected r2 r7)
	(connected r2 r12)
	(connected r12 r2)
	(connected r2 r4)
	(connected r4 r2)
	(connected r4 r15)
	(connected r15 r4)
	(connected r15 r14)
	(connected r14 r15)
	(connected r1 r5)
	(connected r5 r1)
	(connected r5 r9)
	(connected r9 r5)
	(connected r0 r11)
	(connected r11 r0)
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(clear left0)
	(clear right0)
	(clear left1)
	(clear right1)
	(inroom Table0 r6)
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
	(inroom b0 r2)
	(inroom b1 r2)
	(inroom b2 r2)
	(inroom b3 r2)
))
)
