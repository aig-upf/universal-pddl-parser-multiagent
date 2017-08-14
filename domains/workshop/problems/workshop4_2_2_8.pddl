(define (problem workshop4_2_2_8_1) (:domain workshop)
(:objects
	r0n0 - room
	r0n1 - room
	r0n2 - room
	r0n3 - room
	r0n4 - room
	r0n5 - room
	r0n6 - room
	r0n7 - room
	r1n0 - room
	r1n1 - room
	r1n2 - room
	r1n3 - room
	r1n4 - room
	r1n5 - room
	r1n6 - room
	r1n7 - room
	d0 - door
	d1 - door
	d2 - door
	d3 - door
	d4 - door
	d5 - door
	d6 - door
	d7 - door
	d8 - door
	d9 - door
	d10 - door
	d11 - door
	d12 - door
	d13 - door
	d14 - door
	p0 - pallet
	p1 - pallet
	a0 - agent
	a1 - agent
	a2 - agent
	a3 - agent
	f0 - forklift
	f1 - forklift
	k0 - key
	k1 - key
	s0 - switch
	s1 - switch
)
(:init
	(adjacent r0n7 r0n1 d0)
	(adjacent r0n1 r0n7 d0)
	(adjacent r0n1 r0n5 d1)
	(adjacent r0n5 r0n1 d1)
	(adjacent r0n5 r0n4 d2)
	(adjacent r0n4 r0n5 d2)
	(adjacent r0n5 r0n6 d3)
	(adjacent r0n6 r0n5 d3)
	(adjacent r0n5 r0n2 d4)
	(adjacent r0n2 r0n5 d4)
	(adjacent r0n6 r0n0 d5)
	(adjacent r0n0 r0n6 d5)
	(adjacent r0n0 r0n3 d6)
	(adjacent r0n3 r0n0 d6)
	(adjacent r1n2 r1n0 d7)
	(adjacent r1n0 r1n2 d7)
	(adjacent r1n0 r1n7 d8)
	(adjacent r1n7 r1n0 d8)
	(adjacent r1n7 r1n4 d9)
	(adjacent r1n4 r1n7 d9)
	(adjacent r1n4 r1n6 d10)
	(adjacent r1n6 r1n4 d10)
	(adjacent r1n6 r1n3 d11)
	(adjacent r1n3 r1n6 d11)
	(adjacent r1n3 r1n5 d12)
	(adjacent r1n5 r1n3 d12)
	(adjacent r1n3 r1n1 d13)
	(adjacent r1n1 r1n3 d13)
	(adjacent r0n1 r1n5 d14)
	(adjacent r1n5 r0n1 d14)
	(unlocked d0)
	(unlocked d1)
	(unlocked d2)
	(unlocked d3)
	(unlocked d4)
	(unlocked d5)
	(unlocked d6)
	(unlocked d7)
	(unlocked d8)
	(unlocked d9)
	(unlocked d10)
	(unlocked d11)
	(unlocked d12)
	(unlocked d13)
	(locked d14)
	(inroom p0 r1n1)
	(inroom p1 r0n0)
	(inroom a0 r0n6)
	(inroom a1 r0n2)
	(inroom a2 r1n2)
	(inroom a3 r1n1)
	(inroom f0 r0n3)
	(inroom f1 r1n5)
	(inroom k0 r0n3)
	(inroom k1 r1n4)
	(inroom s0 r0n4)
	(inroom s1 r1n7)
	(empty f0)
	(empty f1)
	(connected s0 d14)
	(connected s1 d14)
	(fits k0 d14)
	(fits k1 d14)
)
(:goal (and
	(examined p0)
	(examined p1)
))
)

