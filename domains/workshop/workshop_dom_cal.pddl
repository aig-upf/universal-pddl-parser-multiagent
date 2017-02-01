(define (domain workshop)
(:requirements :typing :conditional-effects :multi-agent)
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
(:concurrent
	(pickup ?a - agent ?k - key ?r - room)
	(unlock ?a - agent ?k - key ?r1 ?r2 - room ?d - door)
	(press-switch ?a - agent ?s - switch ?r - room ?d - door)
	(enter-forklift ?a - agent ?f - forklift ?r - room)
	(exit-forklift ?a - agent ?f - forklift ?r - room)
	(move-agent ?a - agent ?r1 ?r2 - room ?d - door)
	(drive-forklift ?a - agent ?f - forklift ?r1 ?r2 - room ?d - door)
	(examine-pallet ?a - agent ?r - room ?p - pallet)
	(lift-pallet ?a - agent ?f - forklift ?r - room ?p - pallet)
)
(:action pickup
	:parameters (?a - agent ?k - key ?r - room)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?k ?r)
          (forall (?a2 - agent)
            (not (pickup ?a2 ?k ?r))
          )
				  )
	:effect	(and
					(not (inroom ?k ?r))
					(holding ?a ?k)
				 )
)
(:action unlock
	:parameters (?a - agent ?k - key ?r1 ?r2 - room ?d - door)
	:precondition (and
					(inroom ?a ?r1)
					(holding ?a ?k)
					(locked ?d)
					(fits ?k ?d)
					(adjacent ?r1 ?r2 ?d)
					(exists (?a2 - agent ?s - switch)
							(and
								(not (= ?a ?a2))
								(press-switch ?a2 ?s ?r1 ?d)
							)
					)
				  )
	:effect	(and
					(not (locked ?d))
					(unlocked ?d)
				 )
)
(:action press-switch
	:parameters (?a - agent ?s - switch ?r - room ?d - door)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?s ?r)
				  )
	:effect	()
)
(:action enter-forklift
	:parameters (?a - agent ?f - forklift ?r - room)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?f ?r)
					(empty ?f)
					(forall (?a2 - agent ?r2 - room)
							(not (enter-forklift ?a2 ?f ?r2))
					)
				  )
	:effect	(and
					(not (inroom ?a ?r))
					(driving ?a ?f)
					(not (empty ?f))
	)
)
(:action exit-forklift
	:parameters (?a - agent ?f - forklift ?r - room)
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
	:parameters (?a - agent ?r1 ?r2 - room ?d - door)
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
	:parameters (?a - agent ?f - forklift ?r1 ?r2 - room ?d - door)
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
	:parameters (?a - agent ?r - room ?p - pallet)
	:precondition (and
					(inroom ?a ?r)
					(inroom ?p ?r)
					(exists (?a2 - agent ?f - forklift)
							(and
								(not (= ?a ?a2))
								(lift-pallet ?a2 ?f ?r ?p)
							)
					)
				  )
	:effect	(and
					(examined ?p)
				 )
)
(:action lift-pallet
	:parameters (?a - agent ?f - forklift ?r - room ?p - pallet)
	:precondition (and
					(driving ?a ?f)
					(inroom ?f ?r)
					(inroom ?p ?r)
				  )
	:effect	()
)
)
