(define (problem maze15_8_2) (:domain maze)
(:objects
	a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 - agent
	loc1x1 loc1x2 loc1x3 loc1x4 loc1x5 loc1x6 loc1x7 loc1x8 loc2x1 loc2x2 loc2x3 loc2x4 loc2x5 loc2x6 loc2x7 loc2x8 loc3x1 loc3x2 loc3x3 loc3x4 loc3x5 loc3x6 loc3x7 loc3x8 loc4x1 loc4x2 loc4x3 loc4x4 loc4x5 loc4x6 loc4x7 loc4x8 loc5x1 loc5x2 loc5x3 loc5x4 loc5x5 loc5x6 loc5x7 loc5x8 loc6x1 loc6x2 loc6x3 loc6x4 loc6x5 loc6x6 loc6x7 loc6x8 loc7x1 loc7x2 loc7x3 loc7x4 loc7x5 loc7x6 loc7x7 loc7x8 loc8x1 loc8x2 loc8x3 loc8x4 loc8x5 loc8x6 loc8x7 loc8x8 - location
	d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17 d18 d19 d20 d21 d22 d23 d24 d25 d26 d27 d28 d29 d30 d31 d32 d33 d34 d35 d36 d37 d38 d39 d40 d41 d42 d43 d44 d45 d46 d47 d48 d49 d50 d51 d52 d53 d54 d55 d56 d57 d58 d59 d60 d61 d62 d63 d64 d65 d66 d67 d68 d69 d70 d71 d72 d73 d74 d75 d76 d77 d78 d79 d80 d81 d82 d83 d84 d85 d86 d87 d88 d89 d90 d91 d92 d93 d94 d95 d96 - door
	b1 b2 b3 b4 b5 b6 - bridge
	bt1 bt2 bt3 bt4 bt5 bt6 bt7 bt8 bt9 bt10 - boat
	s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 - switch
)
(:init
	(at a1 loc3x3)
	(at a2 loc3x4)
	(at a3 loc4x2)
	(at a4 loc2x5)
	(at a5 loc8x2)
	(at a6 loc2x4)
	(at a7 loc1x1)
	(at a8 loc5x3)
	(at a9 loc3x7)
	(at a10 loc4x3)
	(at a11 loc3x5)
	(at a12 loc4x1)
	(at a13 loc3x2)
	(at a14 loc8x7)
	(at a15 loc5x5)
	(has-door d1 loc1x1 loc1x2)
	(has-door d1 loc1x2 loc1x1)
	(has-door d2 loc1x1 loc2x1)
	(has-door d2 loc2x1 loc1x1)
	(has-door d3 loc1x2 loc1x3)
	(has-door d3 loc1x3 loc1x2)
	(has-door d4 loc1x2 loc2x2)
	(has-door d4 loc2x2 loc1x2)
	(has-door d5 loc1x3 loc1x4)
	(has-door d5 loc1x4 loc1x3)
	(has-door d6 loc1x3 loc2x3)
	(has-door d6 loc2x3 loc1x3)
	(has-door d7 loc1x4 loc1x5)
	(has-door d7 loc1x5 loc1x4)
	(has-door d8 loc1x4 loc2x4)
	(has-door d8 loc2x4 loc1x4)
	(has-door d9 loc1x5 loc1x6)
	(has-door d9 loc1x6 loc1x5)
	(has-door d10 loc1x5 loc2x5)
	(has-door d10 loc2x5 loc1x5)
	(has-door d11 loc1x6 loc1x7)
	(has-door d11 loc1x7 loc1x6)
	(blocked loc1x6 loc1x7)
	(blocked loc1x7 loc1x6)
	(has-switch s1 loc4x2 loc1x6 loc1x7)
	(has-door d12 loc1x6 loc2x6)
	(has-door d12 loc2x6 loc1x6)
	(has-door d13 loc1x7 loc1x8)
	(has-door d13 loc1x8 loc1x7)
	(blocked loc1x7 loc1x8)
	(blocked loc1x8 loc1x7)
	(has-switch s2 loc2x6 loc1x7 loc1x8)
	(has-door d14 loc1x7 loc2x7)
	(has-door d14 loc2x7 loc1x7)
	(blocked loc1x7 loc2x7)
	(blocked loc2x7 loc1x7)
	(has-switch s3 loc1x6 loc1x7 loc2x7)
	(has-door d15 loc1x8 loc2x8)
	(has-door d15 loc2x8 loc1x8)
	(has-door d16 loc2x1 loc2x2)
	(has-door d16 loc2x2 loc2x1)
	(has-door d17 loc2x1 loc3x1)
	(has-door d17 loc3x1 loc2x1)
	(has-door d18 loc2x2 loc2x3)
	(has-door d18 loc2x3 loc2x2)
	(has-door d19 loc2x2 loc3x2)
	(has-door d19 loc3x2 loc2x2)
	(has-boat bt1 loc2x3 loc2x4)
	(has-boat bt1 loc2x4 loc2x3)
	(has-door d20 loc2x3 loc3x3)
	(has-door d20 loc3x3 loc2x3)
	(has-door d21 loc2x4 loc2x5)
	(has-door d21 loc2x5 loc2x4)
	(has-door d22 loc2x4 loc3x4)
	(has-door d22 loc3x4 loc2x4)
	(has-door d23 loc2x5 loc2x6)
	(has-door d23 loc2x6 loc2x5)
	(has-door d24 loc2x5 loc3x5)
	(has-door d24 loc3x5 loc2x5)
	(has-door d25 loc2x6 loc2x7)
	(has-door d25 loc2x7 loc2x6)
	(has-door d26 loc2x6 loc3x6)
	(has-door d26 loc3x6 loc2x6)
	(has-door d27 loc2x7 loc2x8)
	(has-door d27 loc2x8 loc2x7)
	(blocked loc2x7 loc2x8)
	(blocked loc2x8 loc2x7)
	(has-switch s4 loc5x4 loc2x7 loc2x8)
	(has-door d28 loc2x7 loc3x7)
	(has-door d28 loc3x7 loc2x7)
	(has-door d29 loc2x8 loc3x8)
	(has-door d29 loc3x8 loc2x8)
	(has-door d30 loc3x1 loc3x2)
	(has-door d30 loc3x2 loc3x1)
	(has-door d31 loc3x1 loc4x1)
	(has-door d31 loc4x1 loc3x1)
	(has-door d32 loc3x2 loc3x3)
	(has-door d32 loc3x3 loc3x2)
	(has-door d33 loc3x2 loc4x2)
	(has-door d33 loc4x2 loc3x2)
	(has-boat bt2 loc3x3 loc3x4)
	(has-boat bt2 loc3x4 loc3x3)
	(has-door d34 loc3x3 loc4x3)
	(has-door d34 loc4x3 loc3x3)
	(has-door d35 loc3x4 loc3x5)
	(has-door d35 loc3x5 loc3x4)
	(has-door d36 loc3x4 loc4x4)
	(has-door d36 loc4x4 loc3x4)
	(has-bridge b1 loc3x5 loc3x6)
	(has-bridge b1 loc3x6 loc3x5)
	(has-door d37 loc3x5 loc4x5)
	(has-door d37 loc4x5 loc3x5)
	(has-door d38 loc3x6 loc3x7)
	(has-door d38 loc3x7 loc3x6)
	(has-door d39 loc3x6 loc4x6)
	(has-door d39 loc4x6 loc3x6)
	(has-door d40 loc3x7 loc3x8)
	(has-door d40 loc3x8 loc3x7)
	(has-bridge b2 loc3x7 loc4x7)
	(has-bridge b2 loc4x7 loc3x7)
	(has-boat bt3 loc3x8 loc4x8)
	(has-boat bt3 loc4x8 loc3x8)
	(has-boat bt4 loc4x1 loc4x2)
	(has-boat bt4 loc4x2 loc4x1)
	(has-door d41 loc4x1 loc5x1)
	(has-door d41 loc5x1 loc4x1)
	(has-door d42 loc4x2 loc4x3)
	(has-door d42 loc4x3 loc4x2)
	(blocked loc4x2 loc4x3)
	(blocked loc4x3 loc4x2)
	(has-switch s5 loc3x2 loc4x2 loc4x3)
	(has-door d43 loc4x2 loc5x2)
	(has-door d43 loc5x2 loc4x2)
	(blocked loc4x2 loc5x2)
	(blocked loc5x2 loc4x2)
	(has-switch s6 loc1x7 loc4x2 loc5x2)
	(has-door d44 loc4x3 loc4x4)
	(has-door d44 loc4x4 loc4x3)
	(has-door d45 loc4x3 loc5x3)
	(has-door d45 loc5x3 loc4x3)
	(has-door d46 loc4x4 loc4x5)
	(has-door d46 loc4x5 loc4x4)
	(blocked loc4x4 loc4x5)
	(blocked loc4x5 loc4x4)
	(has-switch s7 loc1x2 loc4x4 loc4x5)
	(has-door d47 loc4x4 loc5x4)
	(has-door d47 loc5x4 loc4x4)
	(has-door d48 loc4x5 loc4x6)
	(has-door d48 loc4x6 loc4x5)
	(has-boat bt5 loc4x5 loc5x5)
	(has-boat bt5 loc5x5 loc4x5)
	(has-door d49 loc4x6 loc4x7)
	(has-door d49 loc4x7 loc4x6)
	(has-door d50 loc4x6 loc5x6)
	(has-door d50 loc5x6 loc4x6)
	(has-door d51 loc4x7 loc4x8)
	(has-door d51 loc4x8 loc4x7)
	(has-door d52 loc4x7 loc5x7)
	(has-door d52 loc5x7 loc4x7)
	(has-door d53 loc4x8 loc5x8)
	(has-door d53 loc5x8 loc4x8)
	(has-door d54 loc5x1 loc5x2)
	(has-door d54 loc5x2 loc5x1)
	(has-door d55 loc5x1 loc6x1)
	(has-door d55 loc6x1 loc5x1)
	(has-door d56 loc5x2 loc5x3)
	(has-door d56 loc5x3 loc5x2)
	(has-door d57 loc5x2 loc6x2)
	(has-door d57 loc6x2 loc5x2)
	(has-boat bt6 loc5x3 loc5x4)
	(has-boat bt6 loc5x4 loc5x3)
	(has-door d58 loc5x3 loc6x3)
	(has-door d58 loc6x3 loc5x3)
	(has-door d59 loc5x4 loc5x5)
	(has-door d59 loc5x5 loc5x4)
	(blocked loc5x4 loc5x5)
	(blocked loc5x5 loc5x4)
	(has-switch s8 loc8x8 loc5x4 loc5x5)
	(has-door d60 loc5x4 loc6x4)
	(has-door d60 loc6x4 loc5x4)
	(has-door d61 loc5x5 loc5x6)
	(has-door d61 loc5x6 loc5x5)
	(blocked loc5x5 loc5x6)
	(blocked loc5x6 loc5x5)
	(has-switch s9 loc2x2 loc5x5 loc5x6)
	(has-door d62 loc5x5 loc6x5)
	(has-door d62 loc6x5 loc5x5)
	(has-bridge b3 loc5x6 loc5x7)
	(has-bridge b3 loc5x7 loc5x6)
	(has-door d63 loc5x6 loc6x6)
	(has-door d63 loc6x6 loc5x6)
	(has-door d64 loc5x7 loc5x8)
	(has-door d64 loc5x8 loc5x7)
	(blocked loc5x7 loc5x8)
	(blocked loc5x8 loc5x7)
	(has-switch s10 loc6x3 loc5x7 loc5x8)
	(has-door d65 loc5x7 loc6x7)
	(has-door d65 loc6x7 loc5x7)
	(has-door d66 loc5x8 loc6x8)
	(has-door d66 loc6x8 loc5x8)
	(has-door d67 loc6x1 loc6x2)
	(has-door d67 loc6x2 loc6x1)
	(has-door d68 loc6x1 loc7x1)
	(has-door d68 loc7x1 loc6x1)
	(has-door d69 loc6x2 loc6x3)
	(has-door d69 loc6x3 loc6x2)
	(has-door d70 loc6x2 loc7x2)
	(has-door d70 loc7x2 loc6x2)
	(has-door d71 loc6x3 loc6x4)
	(has-door d71 loc6x4 loc6x3)
	(has-door d72 loc6x3 loc7x3)
	(has-door d72 loc7x3 loc6x3)
	(has-boat bt7 loc6x4 loc6x5)
	(has-boat bt7 loc6x5 loc6x4)
	(has-door d73 loc6x4 loc7x4)
	(has-door d73 loc7x4 loc6x4)
	(has-door d74 loc6x5 loc6x6)
	(has-door d74 loc6x6 loc6x5)
	(has-door d75 loc6x5 loc7x5)
	(has-door d75 loc7x5 loc6x5)
	(has-door d76 loc6x6 loc6x7)
	(has-door d76 loc6x7 loc6x6)
	(blocked loc6x6 loc6x7)
	(blocked loc6x7 loc6x6)
	(has-switch s11 loc4x2 loc6x6 loc6x7)
	(has-door d77 loc6x6 loc7x6)
	(has-door d77 loc7x6 loc6x6)
	(has-door d78 loc6x7 loc6x8)
	(has-door d78 loc6x8 loc6x7)
	(has-door d79 loc6x7 loc7x7)
	(has-door d79 loc7x7 loc6x7)
	(has-bridge b4 loc6x8 loc7x8)
	(has-bridge b4 loc7x8 loc6x8)
	(has-door d80 loc7x1 loc7x2)
	(has-door d80 loc7x2 loc7x1)
	(has-door d81 loc7x1 loc8x1)
	(has-door d81 loc8x1 loc7x1)
	(has-door d82 loc7x2 loc7x3)
	(has-door d82 loc7x3 loc7x2)
	(has-door d83 loc7x2 loc8x2)
	(has-door d83 loc8x2 loc7x2)
	(blocked loc7x2 loc8x2)
	(blocked loc8x2 loc7x2)
	(has-switch s12 loc3x6 loc7x2 loc8x2)
	(has-door d84 loc7x3 loc7x4)
	(has-door d84 loc7x4 loc7x3)
	(has-bridge b5 loc7x3 loc8x3)
	(has-bridge b5 loc8x3 loc7x3)
	(has-door d85 loc7x4 loc7x5)
	(has-door d85 loc7x5 loc7x4)
	(has-boat bt8 loc7x4 loc8x4)
	(has-boat bt8 loc8x4 loc7x4)
	(has-door d86 loc7x5 loc7x6)
	(has-door d86 loc7x6 loc7x5)
	(has-door d87 loc7x5 loc8x5)
	(has-door d87 loc8x5 loc7x5)
	(blocked loc7x5 loc8x5)
	(blocked loc8x5 loc7x5)
	(has-switch s13 loc1x2 loc7x5 loc8x5)
	(has-door d88 loc7x6 loc7x7)
	(has-door d88 loc7x7 loc7x6)
	(has-door d89 loc7x6 loc8x6)
	(has-door d89 loc8x6 loc7x6)
	(has-door d90 loc7x7 loc7x8)
	(has-door d90 loc7x8 loc7x7)
	(has-boat bt9 loc7x7 loc8x7)
	(has-boat bt9 loc8x7 loc7x7)
	(has-door d91 loc7x8 loc8x8)
	(has-door d91 loc8x8 loc7x8)
	(has-door d92 loc8x1 loc8x2)
	(has-door d92 loc8x2 loc8x1)
	(has-door d93 loc8x2 loc8x3)
	(has-door d93 loc8x3 loc8x2)
	(blocked loc8x2 loc8x3)
	(blocked loc8x3 loc8x2)
	(has-switch s14 loc1x4 loc8x2 loc8x3)
	(has-door d94 loc8x3 loc8x4)
	(has-door d94 loc8x4 loc8x3)
	(has-bridge b6 loc8x4 loc8x5)
	(has-bridge b6 loc8x5 loc8x4)
	(has-door d95 loc8x5 loc8x6)
	(has-door d95 loc8x6 loc8x5)
	(has-door d96 loc8x6 loc8x7)
	(has-door d96 loc8x7 loc8x6)
	(has-boat bt10 loc8x7 loc8x8)
	(has-boat bt10 loc8x8 loc8x7)
)
(:goal (and
	(at a1 loc6x8)
	(at a2 loc6x7)
	(at a3 loc3x6)
	(at a4 loc1x3)
	(at a5 loc1x8)
	(at a6 loc5x2)
	(at a7 loc8x5)
	(at a8 loc3x4)
	(at a9 loc5x3)
	(at a10 loc4x7)
	(at a11 loc6x2)
	(at a12 loc8x5)
	(at a13 loc7x3)
	(at a14 loc1x2)
	(at a15 loc2x6)
))
)
