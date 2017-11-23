(define (problem table16_8_2_1) (:domain tablemover)
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
	(inroom b0 r5)
	(inroom b1 r1)
	(inroom b2 r9)
	(inroom b3 r12)
	(inroom b4 r10)
	(inroom b5 r4)
	(inroom b6 r9)
	(inroom b7 r15)
	(inroom a0 r12)
	(inroom a1 r12)
	(inroom a2 r11)
	(inroom a3 r11)
	(available a0)
	(available a1)
	(available a2)
	(available a3)
	(handempty a0)
	(handempty a1)
	(handempty a2)
	(handempty a3)
	(connected r8 r5)
	(connected r5 r8)
	(connected r5 r11)
	(connected r11 r5)
	(connected r11 r15)
	(connected r15 r11)
	(connected r15 r2)
	(connected r2 r15)
	(connected r2 r10)
	(connected r10 r2)
	(connected r2 r0)
	(connected r0 r2)
	(connected r5 r1)
	(connected r1 r5)
	(connected r5 r9)
	(connected r9 r5)
	(connected r11 r12)
	(connected r12 r11)
	(connected r12 r4)
	(connected r4 r12)
	(connected r15 r3)
	(connected r3 r15)
	(connected r0 r13)
	(connected r13 r0)
	(connected r3 r7)
	(connected r7 r3)
	(connected r8 r6)
	(connected r6 r8)
	(connected r13 r14)
	(connected r14 r13)
	(down left0)
	(down right0)
	(down left1)
	(down right1)
	(clear left0)
	(clear right0)
	(clear left1)
	(clear right1)
	(inroom Table0 r12)
	(inroom Table1 r11)
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
	(inroom b0 r11)
	(inroom b1 r11)
	(inroom b2 r11)
	(inroom b3 r11)
	(inroom b4 r11)
	(inroom b5 r11)
	(inroom b6 r11)
	(inroom b7 r11)
))
)
