(define (problem table8_4_1_1) (:domain tablemover)
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
	left0 right0 - side0
)
(:init
	(on-floor b0)
	(on-floor b1)
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r3)
	(inroom b1 r0)
	(inroom b2 r4)
	(inroom b3 r2)
	(inroom a0 r0)
	(inroom a1 r0)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r0 r2)
	(connected r2 r0)
	(connected r2 r4)
	(connected r4 r2)
	(connected r0 r6)
	(connected r6 r0)
	(connected r6 r1)
	(connected r1 r6)
	(connected r1 r7)
	(connected r7 r1)
	(connected r7 r3)
	(connected r3 r7)
	(connected r3 r5)
	(connected r5 r3)
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
	(on-floor b2)
	(on-floor b3)
	(inroom b0 r3)
	(inroom b1 r3)
	(inroom b2 r3)
	(inroom b3 r3)
))
)
