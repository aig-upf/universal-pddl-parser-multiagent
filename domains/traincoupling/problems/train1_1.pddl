(define (problem train1_1) (:domain traincoupling)
(:objects
	l1 - locomotive
	t1 - track
	w1 w2 - wagon
	y1 y2 - yard
)
(:init
	(at-yard l1 y1)
	(at-yard w1 y1)
	(at-yard w2 y1)
	(unattached w1)
	(unattached w2)
	(has-track t1 y1 y2)
)
(:goal (and
	(at-yard w1 y2)
	(at-yard w2 y2)
	(unattached w1)
	(unattached w2)
))
)
