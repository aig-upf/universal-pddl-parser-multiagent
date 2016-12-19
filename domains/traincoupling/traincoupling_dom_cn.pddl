(define (domain traincoupling)
(:requirements :typing :conditional-effects :concurrency-network :multi-agent)
(:types locomotive wagon - agent
		agent track yard)
(:predicates
	(at-yard ?a - agent ?y - yard)
	(attached ?l - locomotive ?w - wagon)
	(unattached ?w - wagon)
	(has-track ?t - track ?y1 ?y2 - yard)
)
(:action move-locomotive
	:agent ?l - locomotive
	:parameters (?t - track ?y1 ?y2 - yard)
	:precondition (and
					(at-yard ?l ?y1)
					(has-track ?t ?y1 ?y2)
				  )
	:effect	(and
					(not (at-yard ?l ?y1))
					(at-yard ?l ?y2)
					(forall (?w - wagon)
						(when (attached ?l ?w)
						      (and (not (at-yard ?w ?y1)) (at-yard ?w ?y2))
						)
					)
				 )
)
(:action attach
	:agent ?w - wagon
	:parameters (?l - locomotive ?y - yard)
	:precondition (and
					(at-yard ?l ?y)
					(at-yard ?w ?y)
					(unattached ?w)
				  )
	:effect	(and 
					(attached ?l ?w)
					(not (unattached ?w))
				 )
)
(:action detach
	:agent ?w - wagon
	:parameters (?l - locomotive ?y - yard)
	:precondition (and
					(at-yard ?l ?y)
					(attached ?l ?w)
				  )
	:effect	(and 
					(not (attached ?l ?w))
					(unattached ?w)
				 )
)
(:concurrency-constraint v1
	:parameters (?l - locomotive)
	:bounds (1 1)
	:actions ( (move-locomotive 0) )
)
(:concurrency-constraint v2
	:parameters (?l - locomotive)
	:bounds (1 inf)
	:actions ( (attach 1) (detach 1) )
)
)
