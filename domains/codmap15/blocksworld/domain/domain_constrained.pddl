(define (domain blocks)
	(:requirements :typing :multi-agent :unfactored-privacy)
(:types
	agent block - object
)
(:predicates
	(on ?x - block ?y - block)
	(ontable ?x - block)
	(clear ?x - block)

	(:private ?agent - agent
		(holding ?agent - agent ?x - block)
		(handempty ?agent - agent)
	)
)

(:action pick-up
	:agent ?a - agent
	:parameters (?x - block)
	:precondition (and
		(clear ?x)
		(ontable ?x)
		(handempty ?a)
		(forall (?a2 - agent) (not (pick-up ?a2 ?x)))
		(forall (?a2 - agent ?z - block) (not (stack ?a2 ?z ?x)))
		(forall (?a2 - agent ?z - block) (not (unstack ?a2 ?x ?z)))
	)
	:effect (and
		(not (ontable ?x))
		(not (clear ?x))
		(not (handempty ?a))
		(holding ?a ?x)
	)
)


(:action put-down
	:agent ?a - agent
	:parameters (?x - block)
	:precondition 
		(holding ?a ?x)
	:effect (and
		(not (holding ?a ?x))
		(clear ?x)
		(handempty ?a)
		(ontable ?x)
	)
)


(:action stack
	:agent ?a - agent
	:parameters (?x - block ?y - block)
	:precondition (and
		(holding ?a ?x)
		(clear ?y)
		(forall (?a2 - agent ?z - block) (not (stack ?a2 ?z ?y)))
		(forall (?a2 - agent ?z - block) (not (unstack ?a2 ?y ?z)))
		(forall (?a2 - agent) (not (pick-up ?a2 ?y)))
	)
	:effect (and
		(not (holding ?a ?x))
		(not (clear ?y))
		(clear ?x)
		(handempty ?a)
		(on ?x ?y)
	)
)


(:action unstack
	:agent ?a - agent
	:parameters (?x - block ?y - block)
	:precondition (and
		(on ?x ?y)
		(clear ?x)
		(handempty ?a)
		(forall (?a2 - agent ?z - block) (not (stack ?a2 ?z ?x)))
		(forall (?a2 - agent) (not (unstack ?a2 ?x ?y)))
		(forall (?a2 - agent) (not (pick-up ?a2 ?x)))
	)
	:effect (and
		(holding ?a ?x)
		(clear ?y)
		(not (clear ?x))
		(not (handempty ?a))
		(not (on ?x ?y))
	)
)

)
