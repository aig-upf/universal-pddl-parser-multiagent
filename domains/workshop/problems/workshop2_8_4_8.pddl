(define (problem workshop2_8_4_8_1) (:domain workshop)
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
	r2n0 - room
	r2n1 - room
	r2n2 - room
	r2n3 - room
	r2n4 - room
	r2n5 - room
	r2n6 - room
	r2n7 - room
	r3n0 - room
	r3n1 - room
	r3n2 - room
	r3n3 - room
	r3n4 - room
	r3n5 - room
	r3n6 - room
	r3n7 - room
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
	d15 - door
	d16 - door
	d17 - door
	d18 - door
	d19 - door
	d20 - door
	d21 - door
	d22 - door
	d23 - door
	d24 - door
	d25 - door
	d26 - door
	d27 - door
	d28 - door
	d29 - door
	d30 - door
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
	(adjacent r0n5 r0n1 d0)
	(adjacent r0n1 r0n5 d0)
	(adjacent r0n1 r0n4 d1)
	(adjacent r0n4 r0n1 d1)
	(adjacent r0n4 r0n2 d2)
	(adjacent r0n2 r0n4 d2)
	(adjacent r0n1 r0n3 d3)
	(adjacent r0n3 r0n1 d3)
	(adjacent r0n1 r0n6 d4)
	(adjacent r0n6 r0n1 d4)
	(adjacent r0n2 r0n0 d5)
	(adjacent r0n0 r0n2 d5)
	(adjacent r0n2 r0n7 d6)
	(adjacent r0n7 r0n2 d6)
	(adjacent r1n5 r1n7 d7)
	(adjacent r1n7 r1n5 d7)
	(adjacent r1n7 r1n2 d8)
	(adjacent r1n2 r1n7 d8)
	(adjacent r1n5 r1n4 d9)
	(adjacent r1n4 r1n5 d9)
	(adjacent r1n4 r1n0 d10)
	(adjacent r1n0 r1n4 d10)
	(adjacent r1n0 r1n1 d11)
	(adjacent r1n1 r1n0 d11)
	(adjacent r1n2 r1n6 d12)
	(adjacent r1n6 r1n2 d12)
	(adjacent r1n4 r1n3 d13)
	(adjacent r1n3 r1n4 d13)
	(adjacent r2n0 r2n5 d14)
	(adjacent r2n5 r2n0 d14)
	(adjacent r2n5 r2n2 d15)
	(adjacent r2n2 r2n5 d15)
	(adjacent r2n2 r2n7 d16)
	(adjacent r2n7 r2n2 d16)
	(adjacent r2n0 r2n6 d17)
	(adjacent r2n6 r2n0 d17)
	(adjacent r2n6 r2n1 d18)
	(adjacent r2n1 r2n6 d18)
	(adjacent r2n5 r2n4 d19)
	(adjacent r2n4 r2n5 d19)
	(adjacent r2n5 r2n3 d20)
	(adjacent r2n3 r2n5 d20)
	(adjacent r3n5 r3n7 d21)
	(adjacent r3n7 r3n5 d21)
	(adjacent r3n7 r3n1 d22)
	(adjacent r3n1 r3n7 d22)
	(adjacent r3n7 r3n6 d23)
	(adjacent r3n6 r3n7 d23)
	(adjacent r3n1 r3n0 d24)
	(adjacent r3n0 r3n1 d24)
	(adjacent r3n0 r3n2 d25)
	(adjacent r3n2 r3n0 d25)
	(adjacent r3n0 r3n4 d26)
	(adjacent r3n4 r3n0 d26)
	(adjacent r3n5 r3n3 d27)
	(adjacent r3n3 r3n5 d27)
	(adjacent r2n7 r3n4 d28)
	(adjacent r3n4 r2n7 d28)
	(adjacent r3n6 r1n7 d29)
	(adjacent r1n7 r3n6 d29)
	(adjacent r1n3 r0n2 d30)
	(adjacent r0n2 r1n3 d30)
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
	(unlocked d14)
	(unlocked d15)
	(unlocked d16)
	(unlocked d17)
	(unlocked d18)
	(unlocked d19)
	(unlocked d20)
	(unlocked d21)
	(unlocked d22)
	(unlocked d23)
	(unlocked d24)
	(unlocked d25)
	(unlocked d26)
	(unlocked d27)
	(locked d28)
	(locked d29)
	(locked d30)
	(inroom p0 r2n4)
	(inroom p1 r1n0)
	(inroom p2 r2n3)
	(inroom p3 r3n5)
	(inroom p4 r0n6)
	(inroom p5 r2n6)
	(inroom p6 r3n3)
	(inroom p7 r3n6)
	(inroom a0 r0n3)
	(inroom a1 r0n5)
	(inroom f0 r0n7)
	(inroom k0 r2n0)
	(inroom k1 r3n1)
	(inroom k2 r3n1)
	(inroom k3 r1n4)
	(inroom k4 r1n2)
	(inroom k5 r0n0)
	(inroom s0 r2n7)
	(inroom s1 r3n6)
	(inroom s2 r3n0)
	(inroom s3 r1n7)
	(inroom s4 r1n6)
	(inroom s5 r0n1)
	(empty f0)
	(connected s0 d28)
	(connected s1 d28)
	(connected s2 d29)
	(connected s3 d29)
	(connected s4 d30)
	(connected s5 d30)
	(fits k0 d28)
	(fits k1 d28)
	(fits k2 d29)
	(fits k3 d29)
	(fits k4 d30)
	(fits k5 d30)
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

