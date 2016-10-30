(define (domain tablemover)
(:requirements :typing :conditional-effects :multi-agent)
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
(:concurrent
	(pickup-floor ?a - agent ?b - block ?r - room)
	(pickup-table ?a - agent ?b - block ?r - room ?t - table)
	(putdown-table ?a - agent ?b - block ?r - room ?t - table)
	(to-table ?a - agent ?r - room ?s - side ?t - table)
	(move-table ?a - agent ?r1 ?r2 - room ?s - side ?t - table)
	(lift-side ?a - agent ?s - side ?t - table)
	(lower-side ?a - agent ?s - side ?t - table)
)
(:action pickup-floor
	:agent ?a - agent
	:parameters (?a - agent ?b - block ?r - room)
	:precondition (and
					(on-floor ?b)
					(inroom ?a ?r)
					(inroom ?b ?r)
					(available ?a)
					(handempty ?a)
					(forall (?a2 - agent) (not (pickup-floor ?a2 ?b ?r)))
				  )
	:effect	(and 
					(not (on-floor ?b))
					(not (handempty ?a))
					(holding ?a ?b)
				 )
)
(:action putdown-floor
	:agent ?a - agent
	:parameters (?a - agent ?b - block)
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
	:parameters (?a - agent ?b - block ?r - room ?t - table)
	:precondition (and
					(on-table ?b ?t)
					(inroom ?a ?r)
					(inroom ?t ?r)
					(available ?a)
					(handempty ?a)
					(forall (?a2 - agent) (not (pickup-table ?a2 ?b ?r ?t)))
				  )
	:effect	(and 
					(not (on-table ?b ?t))
					(not (handempty ?a))
					(holding ?a ?b)
				 )
)
(:action putdown-table
	:agent ?a - agent
	:parameters (?a - agent ?b - block ?r - room ?t - table)
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
	:parameters (?a - agent ?r - room ?s - side ?t - table)
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
	:parameters (?a - agent ?s - side)
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
;	:parameters (?a - agent ?r1 ?r2 - room)
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
	:parameters (?a - agent ?r1 ?r2 - room ?s - side ?t - table)
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
	:parameters (?a - agent ?s - side ?t - table)
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
	:parameters (?a - agent ?s - side ?t - table)
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
)
