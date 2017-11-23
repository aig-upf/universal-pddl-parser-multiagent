(define (problem table16_16_2_1) (:domain tablemover)
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
	(inroom b0 r6)
	(inroom b1 r11)
	(inroom b2 r10)
	(inroom b3 r13)
	(inroom b4 r1)
	(inroom b5 r6)
	(inroom b6 r7)
	(inroom b7 r15)
	(inroom b8 r1)
	(inroom b9 r13)
	(inroom b10 r12)
	(inroom b11 r13)
	(inroom b12 r4)
	(inroom b13 r0)
	(inroom b14 r1)
	(inroom b15 r12)
	(inroom a0 r8)
	(inroom a1 r8)
	(inroom a2 r9)
	(inroom a3 r9)
	(available a0)
	(available a1)
	(available a2)
	(available a3)
	(handempty a0)
	(handempty a1)
	(handempty a2)
	(handempty a3)
	(connected r11 r13)
	(connected r13 r11)
	(connected r13 r8)
	(connected r8 r13)
	(connected r8 r1)
	(connected r1 r8)
	(connected r1 r2)
	(connected r2 r1)
	(connected r2 r12)
	(connected r12 r2)
	(connected r2 r5)
	(connected r5 r2)
	(connected r5 r9)
	(connected r9 r5)
	(connected r9 r15)
	(connected r15 r9)
	(connected r15 r14)
	(connected r14 r15)
	(connected r14 r3)
	(connected r3 r14)
	(connected r13 r6)
	(connected r6 r13)
	(connected r9 r10)
	(connected r10 r9)
	(connected r1 r7)
	(connected r7 r1)
	(connected r10 r0)
	(connected r0 r10)
	(connected r5 r4)
	(connected r4 r5)
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(clear left0)
	(clear right0)
	(clear left1)
	(clear right1)
	(inroom Table0 r8)
	(inroom Table1 r9)
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
	(inroom b0 r15)
	(inroom b1 r15)
	(inroom b2 r15)
	(inroom b3 r15)
	(inroom b4 r15)
	(inroom b5 r15)
	(inroom b6 r15)
	(inroom b7 r15)
	(inroom b8 r15)
	(inroom b9 r15)
	(inroom b10 r15)
	(inroom b11 r15)
	(inroom b12 r15)
	(inroom b13 r15)
	(inroom b14 r15)
	(inroom b15 r15)
))
)
