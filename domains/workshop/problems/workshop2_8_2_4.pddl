(define (problem workshop2_8_2_4_1) (:domain workshop)
(:objects
	r0n0 - room
	r0n1 - room
	r0n2 - room
	r0n3 - room
	r1n0 - room
	r1n1 - room
	r1n2 - room
	r1n3 - room
	d0 - door
	d1 - door
	d2 - door
	d3 - door
	d4 - door
	d5 - door
	d6 - door
	p0 - pallet
	p1 - pallet
	p2 - pallet
	p3 - pallet
	p4 - pallet
	p5 - pallet
	p6 - pallet
	p7 - pallet
	a0 - agent
	a1 - agent
	f0 - forklift
	k0 - key
	k1 - key
	s0 - switch
	s1 - switch
)
(:init
	(adjacent r0n3 r0n2 d0)
	(adjacent r0n2 r0n3 d0)
	(adjacent r0n2 r0n0 d1)
	(adjacent r0n0 r0n2 d1)
	(adjacent r0n0 r0n1 d2)
	(adjacent r0n1 r0n0 d2)
	(adjacent r1n1 r1n0 d3)
	(adjacent r1n0 r1n1 d3)
	(adjacent r1n0 r1n2 d4)
	(adjacent r1n2 r1n0 d4)
	(adjacent r1n2 r1n3 d5)
	(adjacent r1n3 r1n2 d5)
	(adjacent r1n1 r0n0 d6)
	(adjacent r0n0 r1n1 d6)
	(unlocked d0)
	(unlocked d1)
	(unlocked d2)
	(unlocked d3)
	(unlocked d4)
	(unlocked d5)
	(locked d6)
	(inroom p0 r1n2)
	(inroom p1 r1n2)
	(inroom p2 r1n2)
	(inroom p3 r0n2)
	(inroom p4 r0n1)
	(inroom p5 r0n1)
	(inroom p6 r0n1)
	(inroom p7 r0n2)
	(inroom a0 r0n1)
	(inroom a1 r0n1)
	(inroom f0 r0n3)
	(inroom k0 r1n0)
	(inroom k1 r0n2)
	(inroom s0 r1n0)
	(inroom s1 r0n3)
	(empty f0)
	(connected s0 d6)
	(connected s1 d6)
	(fits k0 d6)
	(fits k1 d6)
)
(:goal (and
	(examined p0)
	(examined p1)
	(examined p2)
	(examined p3)
	(examined p4)
	(examined p5)
	(examined p6)
	(examined p7)
))
)

