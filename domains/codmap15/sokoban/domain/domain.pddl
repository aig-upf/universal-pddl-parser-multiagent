(define (domain sokoban-sequential)
	(:requirements :typing :multi-agent :unfactored-privacy)
(:types
	thing location direction - object
	player stone - thing
)
(:predicates
	(at-goal ?s - stone)
	(MOVE-DIR ?from - location ?to - location ?dir - direction)
	(at ?obj - thing ?l - location)
	(IS-NONGOAL ?l - location)
	(clear ?l - location)
	(IS-GOAL ?l - location)
)

(:action move
	:agent ?p - player
	:parameters (?from - location ?to - location ?dir - direction)
	:precondition (and
		(at ?p ?from)
		(clear ?to)
		(MOVE-DIR ?from ?to ?dir)
	)
	:effect (and
		(not (at ?p ?from))
		(not (clear ?to))
		(at ?p ?to)
		(clear ?from)
	)
)


(:action push-to-nongoal
	:agent ?p - player
	:parameters (?s - stone ?ppos - location ?from - location ?to - location ?dir - direction)
	:precondition (and
		(at ?p ?ppos)
		(at ?s ?from)
		(clear ?to)
		(MOVE-DIR ?ppos ?from ?dir)
		(MOVE-DIR ?from ?to ?dir)
		(IS-NONGOAL ?to)
	)
	:effect (and
		(not (at ?p ?ppos))
		(not (at ?s ?from))
		(not (clear ?to))
		(at ?p ?from)
		(at ?s ?to)
		(clear ?ppos)
		(not (at-goal ?s))
	)
)


(:action push-to-goal
	:agent ?p - player
	:parameters (?s - stone ?ppos - location ?from - location ?to - location ?dir - direction)
	:precondition (and
		(at ?p ?ppos)
		(at ?s ?from)
		(clear ?to)
		(MOVE-DIR ?ppos ?from ?dir)
		(MOVE-DIR ?from ?to ?dir)
		(IS-GOAL ?to)
	)
	:effect (and
		(not (at ?p ?ppos))
		(not (at ?s ?from))
		(not (clear ?to))
		(at ?p ?from)
		(at ?s ?to)
		(clear ?ppos)
		(at-goal ?s)
	)
)

)
