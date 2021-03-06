( DEFINE ( DOMAIN TABLEMOVER )
( :REQUIREMENTS :CONDITIONAL-EFFECTS :TYPING :MULTI-AGENT :CONCURRENCY-NETWORK )
( :TYPES
	AGENT - LOCATABLE
	LOCATABLE - OBJECT
	BLOCK - LOCATABLE
	TABLE - LOCATABLE
	ROOM - OBJECT
	SIDE - OBJECT
)
( :PREDICATES
	( ON-TABLE ?BLOCK0 - BLOCK ?TABLE1 - TABLE )
	( ON-FLOOR ?BLOCK0 - BLOCK )
	( DOWN ?SIDE0 - SIDE )
	( CLEAR ?SIDE0 - SIDE )
	( AT-SIDE ?AGENT0 - AGENT ?SIDE1 - SIDE )
	( LIFTING ?AGENT0 - AGENT ?SIDE1 - SIDE )
	( HAS-SIDE ?TABLE0 - TABLE ?SIDE1 - SIDE )
	( INROOM ?LOCATABLE0 - LOCATABLE ?ROOM1 - ROOM )
	( AVAILABLE ?AGENT0 - AGENT )
	( HANDEMPTY ?AGENT0 - AGENT )
	( HOLDING ?AGENT0 - AGENT ?BLOCK1 - BLOCK )
	( CONNECTED ?ROOM0 - ROOM ?ROOM1 - ROOM )
)
( :ACTION PICKUP-FLOOR
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?BLOCK1 - BLOCK ?ROOM2 - ROOM )
  :PRECONDITION
	( AND
		( ON-FLOOR ?BLOCK1 )
		( INROOM ?AGENT ?ROOM2 )
		( INROOM ?BLOCK1 ?ROOM2 )
		( AVAILABLE ?AGENT )
		( HANDEMPTY ?AGENT )
	)
  :EFFECT
	( AND
		( NOT ( ON-FLOOR ?BLOCK1 ) )
		( NOT ( HANDEMPTY ?AGENT ) )
		( HOLDING ?AGENT ?BLOCK1 )
	)
)
( :ACTION PUTDOWN-FLOOR
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?BLOCK1 - BLOCK )
  :PRECONDITION
	( AND
		( AVAILABLE ?AGENT )
		( HOLDING ?AGENT ?BLOCK1 )
	)
  :EFFECT
	( AND
		( ON-FLOOR ?BLOCK1 )
		( HANDEMPTY ?AGENT )
		( NOT ( HOLDING ?AGENT ?BLOCK1 ) )
	)
)
( :ACTION PICKUP-TABLE
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?BLOCK1 - BLOCK ?ROOM2 - ROOM ?TABLE3 - TABLE )
  :PRECONDITION
	( AND
		( ON-TABLE ?BLOCK1 ?TABLE3 )
		( INROOM ?AGENT ?ROOM2 )
		( INROOM ?TABLE3 ?ROOM2 )
		( AVAILABLE ?AGENT )
		( HANDEMPTY ?AGENT )
	)
  :EFFECT
	( AND
		( NOT ( ON-TABLE ?BLOCK1 ?TABLE3 ) )
		( NOT ( HANDEMPTY ?AGENT ) )
		( HOLDING ?AGENT ?BLOCK1 )
	)
)
( :ACTION PUTDOWN-TABLE
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?BLOCK1 - BLOCK ?ROOM2 - ROOM ?TABLE3 - TABLE )
  :PRECONDITION
	( AND
		( INROOM ?AGENT ?ROOM2 )
		( INROOM ?TABLE3 ?ROOM2 )
		( AVAILABLE ?AGENT )
		( HOLDING ?AGENT ?BLOCK1 )
	)
  :EFFECT
	( AND
		( ON-TABLE ?BLOCK1 ?TABLE3 )
		( HANDEMPTY ?AGENT )
		( NOT ( HOLDING ?AGENT ?BLOCK1 ) )
	)
)
( :ACTION TO-TABLE
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?ROOM1 - ROOM ?SIDE2 - SIDE ?TABLE3 - TABLE )
  :PRECONDITION
	( AND
		( CLEAR ?SIDE2 )
		( HAS-SIDE ?TABLE3 ?SIDE2 )
		( INROOM ?AGENT ?ROOM1 )
		( INROOM ?TABLE3 ?ROOM1 )
		( AVAILABLE ?AGENT )
	)
  :EFFECT
	( AND
		( NOT ( CLEAR ?SIDE2 ) )
		( AT-SIDE ?AGENT ?SIDE2 )
		( NOT ( AVAILABLE ?AGENT ) )
	)
)
( :ACTION LEAVE-TABLE
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?SIDE1 - SIDE )
  :PRECONDITION
	( AND
		( AT-SIDE ?AGENT ?SIDE1 )
		( NOT ( LIFTING ?AGENT ?SIDE1 ) )
	)
  :EFFECT
	( AND
		( CLEAR ?SIDE1 )
		( NOT ( AT-SIDE ?AGENT ?SIDE1 ) )
		( AVAILABLE ?AGENT )
	)
)
( :ACTION MOVE-TABLE
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?ROOM1 - ROOM ?ROOM2 - ROOM ?SIDE3 - SIDE ?TABLE4 - TABLE )
  :PRECONDITION
	( AND
		( LIFTING ?AGENT ?SIDE3 )
		( HAS-SIDE ?TABLE4 ?SIDE3 )
		( INROOM ?AGENT ?ROOM1 )
		( CONNECTED ?ROOM1 ?ROOM2 )
	)
  :EFFECT
	( AND
		( NOT ( INROOM ?AGENT ?ROOM1 ) )
		( NOT ( INROOM ?TABLE4 ?ROOM1 ) )
		( INROOM ?AGENT ?ROOM2 )
		( INROOM ?TABLE4 ?ROOM2 )
		( FORALL
			( ?BLOCK5 - BLOCK )
			( WHEN
				( ON-TABLE ?BLOCK5 ?TABLE4 )
				( AND
					( NOT ( INROOM ?BLOCK5 ?ROOM1 ) )
					( INROOM ?BLOCK5 ?ROOM2 )
				)
			)
		)
	)
)
( :ACTION LIFT-SIDE
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?SIDE1 - SIDE ?TABLE2 - TABLE )
  :PRECONDITION
	( AND
		( DOWN ?SIDE1 )
		( AT-SIDE ?AGENT ?SIDE1 )
		( HAS-SIDE ?TABLE2 ?SIDE1 )
		( HANDEMPTY ?AGENT )
	)
  :EFFECT
	( AND
		( NOT ( DOWN ?SIDE1 ) )
		( LIFTING ?AGENT ?SIDE1 )
		( NOT ( HANDEMPTY ?AGENT ) )
	)
)
( :ACTION LOWER-SIDE
  :AGENT ?AGENT - AGENT
  :PARAMETERS ( ?SIDE1 - SIDE ?TABLE2 - TABLE )
  :PRECONDITION
	( AND
		( LIFTING ?AGENT ?SIDE1 )
		( HAS-SIDE ?TABLE2 ?SIDE1 )
	)
  :EFFECT
	( AND
		( DOWN ?SIDE1 )
		( NOT ( LIFTING ?AGENT ?SIDE1 ) )
		( HANDEMPTY ?AGENT )
	)
)
( :CONCURRENCY-CONSTRAINT V1
  :PARAMETERS ( ?BLOCK0 - BLOCK )
  :BOUNDS ( 1 1 )
  :ACTIONS ( ( PICKUP-FLOOR 1 ) ( PUTDOWN-FLOOR 1 ) ( PICKUP-TABLE 1 ) ( PUTDOWN-TABLE 1 ) )
)
( :CONCURRENCY-CONSTRAINT V2
  :PARAMETERS ( ?SIDE0 - SIDE )
  :BOUNDS ( 1 1 )
  :ACTIONS ( ( TO-TABLE 2 ) ( LEAVE-TABLE 1 ) )
)
( :CONCURRENCY-CONSTRAINT V4
  :PARAMETERS ( ?ROOM0 - ROOM ?TABLE1 - TABLE )
  :BOUNDS ( 2 INF )
  :ACTIONS ( ( MOVE-TABLE 2 4 ) )
)
( :CONCURRENCY-CONSTRAINT V5
  :PARAMETERS ( ?TABLE0 - TABLE )
  :BOUNDS ( 2 INF )
  :ACTIONS ( ( LIFT-SIDE 2 ) )
)
( :CONCURRENCY-CONSTRAINT V6
  :PARAMETERS ( ?TABLE0 - TABLE )
  :BOUNDS ( 2 INF )
  :ACTIONS ( ( LOWER-SIDE 2 ) )
)
)
