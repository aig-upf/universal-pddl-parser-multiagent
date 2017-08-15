(define (problem logistics-13-1) (:domain logistics)
(:objects
	obj41 - package
	apt3 - airport
	apt2 - airport
	apt1 - airport
	apt5 - airport
	apt4 - airport
	pos4 - location
	pos5 - location
	pos2 - location
	pos3 - location
	pos1 - location
	obj21 - package
	obj22 - package
	obj23 - package
	obj33 - package
	obj32 - package
	obj31 - package
	obj42 - package
	obj43 - package
	obj53 - package
	obj52 - package
	obj11 - package
	obj51 - package
	obj13 - package
	obj12 - package

	(:private apn2
		apn2 - airplane
	)

	(:private apn1
		apn1 - airplane
	)

	(:private tru5
		tru5 - truck
		cit5 - city
	)

	(:private tru4
		cit4 - city
		tru4 - truck
	)

	(:private tru3
		tru3 - truck
		cit3 - city
	)

	(:private tru2
		cit2 - city
		tru2 - truck
	)

	(:private tru1
		tru1 - truck
		cit1 - city
	)
)
(:init
	(at apn1 apt4)
	(at apn2 apt2)
	(at tru1 pos1)
	(at obj11 pos1)
	(at obj12 pos1)
	(at obj13 pos1)
	(at tru2 pos2)
	(at obj21 pos2)
	(at obj22 pos2)
	(at obj23 pos2)
	(at tru3 pos3)
	(at obj31 pos3)
	(at obj32 pos3)
	(at obj33 pos3)
	(at tru4 pos4)
	(at obj41 pos4)
	(at obj42 pos4)
	(at obj43 pos4)
	(at tru5 pos5)
	(at obj51 pos5)
	(at obj52 pos5)
	(at obj53 pos5)
	(in-city tru1 pos1 cit1)
	(in-city tru1 apt1 cit1)
	(in-city tru2 pos2 cit2)
	(in-city tru2 apt2 cit2)
	(in-city tru3 pos3 cit3)
	(in-city tru3 apt3 cit3)
	(in-city tru4 pos4 cit4)
	(in-city tru4 apt4 cit4)
	(in-city tru5 pos5 cit5)
	(in-city tru5 apt5 cit5)
)
(:goal
	(and
		(at obj12 pos2)
		(at obj53 apt2)
		(at obj51 pos4)
		(at obj11 pos1)
		(at obj23 apt1)
		(at obj13 pos5)
		(at obj52 apt4)
		(at obj42 pos3)
		(at obj22 pos1)
		(at obj33 apt4)
		(at obj21 apt2)
		(at obj41 pos4)
		(at obj31 pos3)
	)
)
)
