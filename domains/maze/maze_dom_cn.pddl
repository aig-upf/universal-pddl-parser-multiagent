(define (domain maze)
(:requirements :typing :concurrency-network :multi-agent)
(:types agent location door bridge boat switch)
(:predicates
	(at ?a - agent ?x - location)
	(has-switch ?s - switch ?x - location ?y - location ?z - location)
	(blocked ?x - location ?y - location)
	(has-door ?d - door ?x - location ?y - location)
	(has-boat ?b - boat ?x - location ?y - location)
	(has-bridge ?b - bridge ?x - location ?y - location)
)
(:action move 
	:agent ?a - agent
	:parameters (?d - door ?x - location ?y - location)
	:precondition (and
					(at ?a ?x)
					(not (blocked ?x ?y))
					(has-door ?d ?x ?y) 
				  )
	:effect	(and 
					(at ?a ?y)
					(not (at ?a ?x))
				 )
)
(:action row 
	:agent ?a - agent
	:parameters (?b - boat ?x - location ?y - location)
	:precondition (and
				(at ?a ?x)
				(has-boat ?b ?x ?y)
			 )
	:effect	(and 
			(at ?a ?y)
			(not (at ?a ?x)) 
		)
)
(:action cross 
	:agent ?a - agent
	:parameters (?b - bridge ?x - location ?y - location) 
	:precondition (and
					(at ?a ?x)
					(has-bridge ?b ?x ?y) 
			)
	:effect	(and 
					(at ?a ?y)
					(not (at ?a ?x))
					(not (has-bridge ?b ?x ?y))
					(not (has-bridge ?b ?y ?x))
			 )
)
(:action pushswitch
	:agent ?a - agent
	:parameters (?s - switch ?x - location ?y - location ?z - location)
	:precondition (and
					(at ?a ?x)
					(has-switch ?s ?x ?y ?z)
			 	  )
	:effect	(and
				(not (blocked ?y ?z))
				(not (blocked ?z ?y))
	)
)
(:concurrency-constraint v1
	:parameters (?d - door)
	:bounds (1 1)
	:actions ( (move 1) )
)
(:concurrency-constraint v2
	:parameters (?b - boat ?x - location)
	:bounds (2 inf)
	:actions ( (row 1 2) )
)
(:concurrency-constraint v3
	:parameters (?b - bridge)
	:bounds (1 inf)
	:actions ( (cross 1) )
)
(:concurrency-constraint v4
	:parameters (?s - switch)
	:bounds (1 1)
	:actions ( (pushswitch 1) )
)
)
