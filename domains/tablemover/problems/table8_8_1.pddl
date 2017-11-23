(define (problem table8_8_1_1) (:domain tablemover)
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
	(inroom b0 r1)
	(inroom b1 r3)
	(inroom b2 r6)
	(inroom b3 r7)
	(inroom b4 r7)
	(inroom b5 r7)
	(inroom b6 r6)
	(inroom b7 r1)
	(inroom a0 r5)
	(inroom a1 r5)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r7 r6)
	(connected r6 r7)
	(connected r6 r1)
	(connected r1 r6)
	(connected r1 r3)
	(connected r3 r1)
	(connected r7 r5)
	(connected r5 r7)
	(connected r5 r0)
	(connected r0 r5)
	(connected r0 r2)
	(connected r2 r0)
	(connected r5 r4)
	(connected r4 r5)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r5)
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
	(inroom b0 r0)
	(inroom b1 r0)
	(inroom b2 r0)
	(inroom b3 r0)
	(inroom b4 r0)
	(inroom b5 r0)
	(inroom b6 r0)
	(inroom b7 r0)
))
)
