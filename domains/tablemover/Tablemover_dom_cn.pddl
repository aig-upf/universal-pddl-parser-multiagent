(define (domain tablemover)
(:requirements :typing :conditional-effects :multi-agent :concurrency-network)
(:types agent block table - locatable
		locatable room side)
(:predicates
	(on-table ?b - block ?t - table)
	(on-floor ?b - block)
	(down ?s - side)
	(clear ?s - side)
	(at-side ?a - agent ?s - side)
	(lifting ?a - agent ?s - side)
	(has-side ?t - table ?s - side)
	(inroom ?l - locatable ?r - room)
	(available ?a - agent)
	(handempty ?a - agent)
	(holding ?a - agent ?b - block)
	(connected ?r1 ?r2 - room)
)
(:action pickup-floor
	:agent ?a - agent
	:parameters (?b - block ?r - room)
	:precondition (and
					(on-floor ?b)
					(inroom ?a ?r)
					(inroom ?b ?r)
					(available ?a)
					(handempty ?a)
				  )
	:effect	(and 
					(not (on-floor ?b))
					(not (handempty ?a))
					(holding ?a ?b)
				 )
)
(:action putdown-floor
	:agent ?a - agent
	:parameters (?b - block)
	:precondition (and
					(available ?a)
					(holding ?a ?b)
				  )
	:effect	(and 
					(on-floor ?b)
					(handempty ?a)
					(not (holding ?a ?b))
				 )
)
(:action pickup-table
	:agent ?a - agent
	:parameters (?b - block ?r - room ?t - table)
	:precondition (and
					(on-table ?b ?t)
					(inroom ?a ?r)
					(inroom ?t ?r)
					(available ?a)
					(handempty ?a)
				  )
	:effect	(and 
					(not (on-table ?b ?t))
					(not (handempty ?a))
					(holding ?a ?b)
				 )
)
(:action putdown-table
	:agent ?a - agent
	:parameters (?b - block ?r - room ?t - table)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?t ?r)
					(available ?a)
					(holding ?a ?b)
				  )
	:effect	(and 
					(on-table ?b ?t)
					(handempty ?a)
					(not (holding ?a ?b))
				 )
)
(:action to-table
	:agent ?a - agent
	:parameters (?r - room ?s - side ?t - table)
	:precondition (and
					(clear ?s)
					(has-side ?t ?s)
					(inroom ?a ?r)
					(inroom ?t ?r)
					(available ?a)
				  )
	:effect	(and
					(not (clear ?s))
					(at-side ?a ?s)
					(not (available ?a))
				 )
)
(:action leave-table
	:agent ?a - agent
	:parameters (?s - side)
	:precondition (and
					(at-side ?a ?s)
					(not (lifting ?a ?s))
				  )
	:effect	(and
					(clear ?s)
					(not (at-side ?a ?s))
					(available ?a)
				 )
)
;(:action move-agent
;	:agent ?a - agent
;	:parameters (?r1 ?r2 - room)
;	:precondition (and
;					(inroom ?a ?r1)
;					(connected ?r1 ?r2)
;				  )
;	:effect	(and
;					(not (inroom ?a ?r1))
;					(inroom ?a ?r2)
;					(forall (?b - block)
;						(when (holding ?a ?b)
;						      (and (not (inroom ?b ?r1)) (inroom ?b ?r2))
;						)
;					)
;				 )
;)
(:action move-table
	:agent ?a - agent
	:parameters (?r1 ?r2 - room ?s - side ?t - table)
	:precondition (and
					(lifting ?a ?s)
					(has-side ?t ?s)
					(inroom ?a ?r1)
					(connected ?r1 ?r2)
				  )
	:effect	(and
					(not (inroom ?a ?r1))
					(not (inroom ?t ?r1))
					(inroom ?a ?r2)
					(inroom ?t ?r2)
					(forall (?b - block)
						(when (on-table ?b ?t)
						      (and (not (inroom ?b ?r1)) (inroom ?b ?r2))
						)
					)
				 )
)
(:action lift-side
	:agent ?a - agent
	:parameters (?s - side ?t - table)
	:precondition (and
					(down ?s)
					(at-side ?a ?s)
					(has-side ?t ?s)
					(handempty ?a)
				  )
	:effect	(and
					(not (down ?s))
					(lifting ?a ?s)
					(not (handempty ?a))
				 )
)
(:action lower-side
	:agent ?a - agent
	:parameters (?s - side ?t - table)
	:precondition (and
					(lifting ?a ?s)
					(has-side ?t ?s)
				  )
	:effect	(and
					(down ?s)
					(not (lifting ?a ?s))
					(handempty ?a)
				 )
)
(:concurrency-constraint v1
	:parameters (?b - block)
	:bounds (1 1)
	:actions ( (pickup-floor 1) (putdown-floor 1) (pickup-table 1) (putdown-table 1) )
)
(:concurrency-constraint v2
	:parameters (?s - side)
	:bounds (1 1)
	:actions ( (to-table 2) (leave-table 1) )
)
;(:concurrency-constraint v3
;	:parameters (?a - agent)
;	:bounds (1 1)
;	:actions ( (move-agent 0) )
;)
(:concurrency-constraint v4
	:parameters (?r - room ?t - table)
	:bounds (2 inf)
	:actions ( (move-table 2 4) )
)
(:concurrency-constraint v5
	:parameters (?t - table)
	:bounds (2 inf)
	:actions ( (lift-side 2) )
)
(:concurrency-constraint v6
	:parameters (?t - table)
	:bounds (2 inf)
	:actions ( (lower-side 2) )
)
)
