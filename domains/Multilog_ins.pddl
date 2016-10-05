(define (problem logistics-4-0)
(:domain logistics)
(:objects
 pos1 - location
 apt2 - location
 obj11 - package
 apt1 - location
 obj22 - package
 obj21 - package
 obj23 - package
 obj13 - package
 obj12 - package

 (:private apn1
  apn1 - airplane
 )

 (:private tru2
  tru2 - truck
  pos2 - location
  cit2 - city
 )

 (:private tru1
  tru1 - truck
  cit1 - city
 )
)
(:init 
 (at apn1 apt2) (at tru1 pos1) (at obj11 pos1)
 (at obj12 pos1) (at obj13 pos1) (at tru2 pos2) (at obj21 pos2) (at obj22 pos2)
 (at obj23 pos2) (in-city pos1 cit1) (in-city apt1 cit1) (in-city pos2 cit2)
 (in-city apt2 cit2))
(:goal (and (at obj11 apt1) (at obj23 pos1) (at obj13 apt1) (at obj21 pos1)))
)
