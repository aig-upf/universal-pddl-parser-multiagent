(define (domain workshop)
(:requirements :typing :conditional-effects :concurrency-network :multi-agent)
(:types agent forklift key pallet switch - locatable
        door locatable room)
(:predicates
	(inroom ?l - locatable ?r - room)

	(empty ?f - forklift)
	(holding ?a - agent ?k - key)
	(driving ?a - agent ?f - forklift)

	(locked ?d - door)
	(unlocked ?d - door)
	(fits ?k - key ?d - door)
	(connected ?s - switch ?d - door)

	(examined ?p - pallet)

	(adjacent ?r1 ?r2 - room ?d - door)
)
(:action pickup
	:agent ?a - agent
	:parameters (?k - key ?r - room)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?k ?r)
				  )
	:effect	(and 
					(not (inroom ?k ?r))
					(holding ?a ?k)
				 )
)
(:action unlock
	:agent ?a - agent
	:parameters (?k - key ?r1 ?r2 - room ?d - door)
	:precondition (and
					(inroom ?a ?r1)
					(holding ?a ?k)
					(locked ?d)
					(fits ?k ?d)
					(adjacent ?r1 ?r2 ?d)
				  )
	:effect	(and 
					(not (locked ?d))
					(unlocked ?d)
				 )
)
(:action press-switch
	:agent ?a - agent
	:parameters (?s - switch ?r - room ?d - door)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?s ?r)
					(connected ?s ?d)
				  )
	:effect	()
)
(:action enter-forklift
	:agent ?a - agent
	:parameters (?f - forklift ?r - room)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?f ?r)
					(empty ?f)
				  )
	:effect	(and
					(not (inroom ?a ?r))
					(driving ?a ?f)
					(not (empty ?f))
	)
)
(:action exit-forklift
	:agent ?a - agent
	:parameters (?f - forklift ?r - room)
	:precondition (and
					(driving ?a ?f)
					(inroom ?f ?r)
				  )
	:effect	(and
					(inroom ?a ?r)
					(not (driving ?a ?f))
					(empty ?f)
	)
)
(:action move-agent
	:agent ?a - agent
	:parameters (?r1 ?r2 - room ?d - door)
	:precondition (and
					(inroom ?a ?r1)
					(unlocked ?d)
					(adjacent ?r1 ?r2 ?d)
				  )
	:effect	(and 
					(not (inroom ?a ?r1))
					(inroom ?a ?r2)
				 )
)
(:action drive-forklift
	:agent ?a - agent
	:parameters (?f - forklift ?r1 ?r2 - room ?d - door)
	:precondition (and
					(driving ?a ?f)
					(inroom ?f ?r1)
					(unlocked ?d)
					(adjacent ?r1 ?r2 ?d)
				  )
	:effect	(and 
					(not (inroom ?f ?r1))
					(inroom ?f ?r2)
				 )
)
(:action examine-pallet
	:agent ?a - agent
	:parameters (?r - room ?p - pallet)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?p ?r)
				  )
	:effect	(and 
					(examined ?p)
				 )
)
(:action lift-pallet
	:agent ?a - agent
	:parameters (?f - forklift ?r - room ?p - pallet)
	:precondition (and
					(driving ?a ?f)
					(inroom ?f ?r)
					(inroom ?p ?r)
				  )
	:effect	()
)
(:concurrency-constraint v1
	:parameters (?k - key)
	:bounds (1 1)
	:actions ( (pickup 1) )
)
(:concurrency-constraint v2
	:parameters (?d - door)
	:bounds (1 1)
	:actions ( (unlock 4) )
)
(:concurrency-constraint v3
	:parameters (?d - door)
	:bounds (1 1)
	:actions ( (press-switch 3) )
)
(:concurrency-constraint v4
	:parameters (?f - forklift)
	:bounds (1 1)
	:actions ( (enter-forklift 1) (exit-forklift 1) )
)
(:concurrency-constraint v5
	:parameters (?a - agent)
	:bounds (1 1)
	:actions ( (move-agent 0) (drive-forklift 0) )
)
(:concurrency-constraint v6
	:parameters (?p - pallet)
	:bounds (1 1)
	:actions ( (examine-pallet 2) )
)
(:concurrency-constraint v7
	:parameters (?p - pallet)
	:bounds (1 1)
	:actions ( (lift-pallet 3) )
)
(:positive-dependence v3 v2)
(:positive-dependence v7 v6)
)
