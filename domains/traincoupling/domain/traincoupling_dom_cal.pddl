(define (domain traincoupling)
(:requirements :typing :conditional-effects :multi-agent)
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
                    (forall (?w - wagon)
                            (and 
                                (not (attach ?w ?l ?y1))
                                (not (detach ?w ?l ?y1))
                            )
                    )
                    (forall (?l2 - locomotive)
                            (and
                                (not (move-locomotive ?l2 ?t ?y1 ?y2))
                                (not (move-locomotive ?l2 ?t ?y2 ?y1))
                            )
                    )
                  )
    :effect (and
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
    :effect (and
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
    :effect (and
                (not (attached ?l ?w))
                (unattached ?w)
             )
)
)
