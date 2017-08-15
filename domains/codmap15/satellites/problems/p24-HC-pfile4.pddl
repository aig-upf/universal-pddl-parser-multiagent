(define (problem strips-sat-x-1) (:domain satellite)
(:objects
	planet11 - direction
	planet10 - direction
	planet12 - direction
	planet16 - direction
	planet19 - direction
	planet18 - direction
	star54 - direction
	star70 - direction
	phenomenon34 - direction
	phenomenon33 - direction
	star38 - direction
	star37 - direction
	star35 - direction
	thermograph2 - mode
	star31 - direction
	star30 - direction
	phenomenon72 - direction
	planet48 - direction
	planet49 - direction
	planet42 - direction
	planet41 - direction
	groundstation1 - direction
	planet64 - direction
	planet29 - direction
	planet67 - direction
	planet63 - direction
	planet21 - direction
	planet68 - direction
	planet25 - direction
	phenomenon20 - direction
	phenomenon69 - direction
	phenomenon26 - direction
	star40 - direction
	phenomenon61 - direction
	phenomenon60 - direction
	phenomenon62 - direction
	star4 - direction
	star7 - direction
	star6 - direction
	planet44 - direction
	star2 - direction
	planet56 - direction
	planet50 - direction
	planet28 - direction
	planet39 - direction
	planet71 - direction
	planet32 - direction
	planet36 - direction
	star59 - direction
	star58 - direction
	star17 - direction
	star53 - direction
	phenomenon13 - direction
	phenomenon14 - direction
	phenomenon15 - direction
	phenomenon55 - direction
	phenomenon57 - direction
	phenomenon51 - direction
	phenomenon52 - direction
	star0 - direction
	planet24 - direction
	planet5 - direction
	star65 - direction
	star66 - direction
	planet3 - direction
	phenomenon8 - direction
	phenomenon9 - direction
	star22 - direction
	star23 - direction
	star27 - direction
	infrared0 - mode
	infrared1 - mode
	phenomenon47 - direction
	phenomenon46 - direction
	phenomenon45 - direction
	phenomenon43 - direction

	(:private satellite0
		satellite0 - satellite
		instrument0 - instrument
		instrument1 - instrument
	)

	(:private satellite1
		satellite1 - satellite
		instrument3 - instrument
		instrument2 - instrument
	)

	(:private satellite2
		satellite2 - satellite
		instrument4 - instrument
		instrument5 - instrument
	)

	(:private satellite3
		satellite3 - satellite
		instrument7 - instrument
		instrument6 - instrument
	)

	(:private satellite4
		satellite4 - satellite
		instrument8 - instrument
	)

	(:private satellite5
		satellite5 - satellite
		instrument9 - instrument
		instrument10 - instrument
		instrument11 - instrument
	)

	(:private satellite6
		satellite6 - satellite
		instrument14 - instrument
		instrument12 - instrument
		instrument13 - instrument
	)
)
(:init
	(supports instrument0 infrared0)
	(supports instrument0 thermograph2)
	(supports instrument0 infrared1)
	(calibration_target instrument0 star2)
	(supports instrument1 infrared0)
	(supports instrument1 infrared1)
	(supports instrument1 thermograph2)
	(calibration_target instrument1 star0)
	(on_board instrument0 satellite0)
	(on_board instrument1 satellite0)
	(power_avail satellite0)
	(pointing satellite0 planet21)
	(supports instrument2 thermograph2)
	(supports instrument2 infrared1)
	(supports instrument2 infrared0)
	(calibration_target instrument2 star0)
	(supports instrument3 thermograph2)
	(supports instrument3 infrared1)
	(calibration_target instrument3 star0)
	(on_board instrument2 satellite1)
	(on_board instrument3 satellite1)
	(power_avail satellite1)
	(pointing satellite1 planet10)
	(supports instrument4 infrared1)
	(calibration_target instrument4 star2)
	(supports instrument5 thermograph2)
	(supports instrument5 infrared0)
	(supports instrument5 infrared1)
	(calibration_target instrument5 star2)
	(on_board instrument4 satellite2)
	(on_board instrument5 satellite2)
	(power_avail satellite2)
	(pointing satellite2 star17)
	(supports instrument6 thermograph2)
	(supports instrument6 infrared1)
	(supports instrument6 infrared0)
	(calibration_target instrument6 groundstation1)
	(supports instrument7 thermograph2)
	(calibration_target instrument7 groundstation1)
	(on_board instrument6 satellite3)
	(on_board instrument7 satellite3)
	(power_avail satellite3)
	(pointing satellite3 phenomenon8)
	(supports instrument8 thermograph2)
	(supports instrument8 infrared1)
	(supports instrument8 infrared0)
	(calibration_target instrument8 star0)
	(on_board instrument8 satellite4)
	(power_avail satellite4)
	(pointing satellite4 planet24)
	(supports instrument9 infrared0)
	(supports instrument9 infrared1)
	(supports instrument9 thermograph2)
	(calibration_target instrument9 star0)
	(supports instrument10 infrared1)
	(supports instrument10 infrared0)
	(calibration_target instrument10 star0)
	(supports instrument11 infrared0)
	(supports instrument11 infrared1)
	(supports instrument11 thermograph2)
	(calibration_target instrument11 groundstation1)
	(on_board instrument9 satellite5)
	(on_board instrument10 satellite5)
	(on_board instrument11 satellite5)
	(power_avail satellite5)
	(pointing satellite5 planet5)
	(supports instrument12 infrared0)
	(calibration_target instrument12 groundstation1)
	(supports instrument13 thermograph2)
	(calibration_target instrument13 star2)
	(supports instrument14 infrared0)
	(supports instrument14 thermograph2)
	(supports instrument14 infrared1)
	(calibration_target instrument14 groundstation1)
	(on_board instrument12 satellite6)
	(on_board instrument13 satellite6)
	(on_board instrument14 satellite6)
	(power_avail satellite6)
	(pointing satellite6 planet24)
)
(:goal
	(and
		(have_image planet3 infrared1)
		(have_image star4 infrared1)
		(have_image planet5 thermograph2)
		(have_image star6 infrared1)
		(have_image star7 infrared0)
		(have_image phenomenon8 thermograph2)
		(have_image phenomenon9 infrared0)
		(have_image planet10 infrared0)
		(have_image planet11 infrared1)
		(have_image planet12 thermograph2)
		(have_image phenomenon14 infrared0)
		(have_image phenomenon15 infrared0)
		(have_image planet16 infrared1)
		(have_image planet18 infrared0)
		(have_image planet19 infrared0)
		(have_image phenomenon20 infrared1)
		(have_image planet21 infrared0)
		(have_image star22 infrared1)
		(have_image star23 thermograph2)
		(have_image planet24 infrared1)
		(have_image planet25 infrared0)
		(have_image phenomenon26 thermograph2)
		(have_image star27 infrared0)
		(have_image planet28 infrared0)
		(have_image planet29 infrared0)
		(have_image star30 infrared1)
		(have_image planet32 thermograph2)
		(have_image phenomenon33 infrared0)
		(have_image phenomenon34 infrared1)
		(have_image star35 thermograph2)
		(have_image planet36 infrared0)
		(have_image star37 thermograph2)
		(have_image star38 thermograph2)
		(have_image planet39 infrared1)
		(have_image star40 thermograph2)
		(have_image planet41 thermograph2)
		(have_image planet42 infrared0)
		(have_image phenomenon43 thermograph2)
		(have_image planet44 infrared1)
		(have_image phenomenon45 thermograph2)
		(have_image phenomenon46 infrared0)
		(have_image phenomenon47 infrared0)
		(have_image planet48 thermograph2)
		(have_image planet49 thermograph2)
		(have_image planet50 thermograph2)
		(have_image phenomenon51 thermograph2)
		(have_image phenomenon52 infrared1)
		(have_image star53 infrared1)
		(have_image star54 infrared0)
		(have_image phenomenon55 thermograph2)
		(have_image planet56 thermograph2)
		(have_image phenomenon57 thermograph2)
		(have_image star58 infrared1)
		(have_image star59 thermograph2)
		(have_image phenomenon60 infrared0)
		(have_image phenomenon61 thermograph2)
		(have_image phenomenon62 infrared0)
		(have_image planet63 thermograph2)
		(have_image planet64 infrared0)
		(have_image star65 infrared1)
		(have_image planet67 thermograph2)
		(have_image planet68 infrared0)
		(have_image phenomenon69 infrared0)
		(have_image star70 infrared1)
		(have_image planet71 infrared1)
		(have_image phenomenon72 infrared0)
	)
)
)
