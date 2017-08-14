(define (problem workshop4_4_4_4_1) (:domain workshop)
(:objects
	r0n0 - room
	r0n1 - room
	r0n2 - room
	r0n3 - room
	r1n0 - room
	r1n1 - room
	r1n2 - room
	r1n3 - room
	r2n0 - room
	r2n1 - room
	r2n2 - room
	r2n3 - room
	r3n0 - room
	r3n1 - room
	r3n2 - room
	r3n3 - room
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
	p2 - pallet
	p3 - pallet
	a0 - agent
	a1 - agent
	a2 - agent
	a3 - agent
	f0 - forklift
	f1 - forklift
	k0 - key
	k1 - key
	k2 - key
	k3 - key
	k4 - key
	k5 - key
	s0 - switch
	s1 - switch
	s2 - switch
	s3 - switch
	s4 - switch
	s5 - switch
)
(:init
	(adjacent r0n1 r0n3 d0)
	(adjacent r0n3 r0n1 d0)
	(adjacent r0n3 r0n2 d1)
	(adjacent r0n2 r0n3 d1)
	(adjacent r0n2 r0n0 d2)
	(adjacent r0n0 r0n2 d2)
	(adjacent r1n3 r1n0 d3)
	(adjacent r1n0 r1n3 d3)
	(adjacent r1n0 r1n1 d4)
	(adjacent r1n1 r1n0 d4)
	(adjacent r1n1 r1n2 d5)
	(adjacent r1n2 r1n1 d5)
	(adjacent r2n0 r2n3 d6)
	(adjacent r2n3 r2n0 d6)
	(adjacent r2n0 r2n1 d7)
	(adjacent r2n1 r2n0 d7)
	(adjacent r2n1 r2n2 d8)
	(adjacent r2n2 r2n1 d8)
	(adjacent r3n2 r3n3 d9)
	(adjacent r3n3 r3n2 d9)
	(adjacent r3n3 r3n1 d10)
	(adjacent r3n1 r3n3 d10)
	(adjacent r3n1 r3n0 d11)
	(adjacent r3n0 r3n1 d11)
	(adjacent r1n3 r2n1 d12)
	(adjacent r2n1 r1n3 d12)
	(adjacent r2n3 r3n0 d13)
	(adjacent r3n0 r2n3 d13)
	(adjacent r2n2 r0n3 d14)
	(adjacent r0n3 r2n2 d14)
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
	(locked d12)
	(locked d13)
	(locked d14)
	(inroom p0 r3n1)
	(inroom p1 r1n3)
	(inroom p2 r3n1)
	(inroom p3 r3n0)
	(inroom a0 r1n3)
	(inroom a1 r1n0)
	(inroom a2 r2n3)
	(inroom a3 r2n0)
	(inroom f0 r1n0)
	(inroom f1 r2n0)
	(inroom k0 r1n3)
	(inroom k1 r2n1)
	(inroom k2 r2n0)
	(inroom k3 r3n3)
	(inroom k4 r2n2)
	(inroom k5 r0n1)
	(inroom s0 r1n1)
	(inroom s1 r2n1)
	(inroom s2 r2n2)
	(inroom s3 r3n3)
	(inroom s4 r2n0)
	(inroom s5 r0n0)
	(empty f0)
	(empty f1)
	(connected s0 d12)
	(connected s1 d12)
	(connected s2 d13)
	(connected s3 d13)
	(connected s4 d14)
	(connected s5 d14)
	(fits k0 d12)
	(fits k1 d12)
	(fits k2 d13)
	(fits k3 d13)
	(fits k4 d14)
	(fits k5 d14)
)
(:goal (and
	(examined p0)
	(examined p1)
	(examined p2)
	(examined p3)
))
)

