(define (problem table8_2_1_1) (:domain tablemover)
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
	left0 right0 - side0
)
(:init
	(on-floor b0)
	(on-floor b1)
	(inroom b0 r4)
	(inroom b1 r0)
	(inroom a0 r4)
	(inroom a1 r4)
	(available a0)
	(available a1)
	(handempty a0)
	(handempty a1)
	(connected r3 r6)
	(connected r6 r3)
	(connected r6 r1)
	(connected r1 r6)
	(connected r1 r0)
	(connected r0 r1)
	(connected r0 r2)
	(connected r2 r0)
	(connected r2 r7)
	(connected r7 r2)
	(connected r7 r5)
	(connected r5 r7)
	(connected r7 r4)
	(connected r4 r7)
	(down left0)
	(down right0)
	(clear left0)
	(clear right0)
	(inroom Table0 r4)
)
(:goal (and
	(down left0)
	(down right0)
	(on-floor b0)
	(on-floor b1)
	(inroom b0 r1)
	(inroom b1 r1)
))
)
