(define (problem strips-sat-x-1) (:domain satellite)
(:objects
	planet11 - direction
	planet13 - direction
	planet38 - direction
	planet14 - direction
	planet19 - direction
	planet24 - direction
	planet31 - direction
	planet37 - direction
	planet39 - direction
	planet34 - direction
	star36 - direction
	star15 - direction
	phenomenon35 - direction
	phenomenon32 - direction
	star10 - direction
	thermograph0 - mode
	phenomenon12 - direction
	star33 - direction
	phenomenon16 - direction
	star30 - direction
	planet42 - direction
	groundstation2 - direction
	groundstation1 - direction
	phenomenon18 - direction
	star21 - direction
	planet22 - direction
	planet26 - direction
	planet27 - direction
	phenomenon6 - direction
	planet7 - direction
	image1 - mode
	planet8 - direction
	phenomenon20 - direction
	phenomenon25 - direction
	phenomenon29 - direction
	phenomenon28 - direction
	planet23 - direction
	star41 - direction
	phenomenon17 - direction
	phenomenon4 - direction
	star5 - direction
	spectrograph2 - mode
	star0 - direction
	phenomenon40 - direction
	star9 - direction
	phenomenon3 - direction

	(:private satellite0
		satellite0 - satellite
		instrument0 - instrument
		instrument1 - instrument
		instrument2 - instrument
	)

	(:private satellite1
		satellite1 - satellite
		instrument3 - instrument
		instrument4 - instrument
		instrument5 - instrument
		
	)

	(:private satellite2
		satellite2 - satellite
		instrument6 - instrument
		instrument7 - instrument
		
	)

	(:private satellite3
		satellite3 - satellite
		instrument8 - instrument
		
	)

	(:private satellite4
		satellite4 - satellite
		instrument9 - instrument
		instrument10 - instrument
		
	)

	
)
(:init
	(supports instrument0 spectrograph2)
	(calibration_target instrument0 groundstation1)
	(supports instrument1 thermograph0)
	(supports instrument1 image1)
	(supports instrument1 spectrograph2)
	(calibration_target instrument1 star0)
	(supports instrument2 thermograph0)
	(supports instrument2 spectrograph2)
	(calibration_target instrument2 groundstation1)
	(on_board instrument0 satellite0)
	(on_board instrument1 satellite0)
	(on_board instrument2 satellite0)
	(power_avail satellite0)
	(pointing satellite0 groundstation2)
	(supports instrument3 image1)
	(calibration_target instrument3 groundstation1)
	(supports instrument4 image1)
	(supports instrument4 spectrograph2)
	(supports instrument4 thermograph0)
	(calibration_target instrument4 groundstation2)
	(supports instrument5 spectrograph2)
	(supports instrument5 thermograph0)
	(calibration_target instrument5 groundstation1)
	(on_board instrument3 satellite1)
	(on_board instrument4 satellite1)
	(on_board instrument5 satellite1)
	(power_avail satellite1)
	(pointing satellite1 planet11)
	(supports instrument6 image1)
	(calibration_target instrument6 groundstation2)
	(supports instrument7 image1)
	(supports instrument7 spectrograph2)
	(supports instrument7 thermograph0)
	(calibration_target instrument7 groundstation2)
	(on_board instrument6 satellite2)
	(on_board instrument7 satellite2)
	(power_avail satellite2)
	(pointing satellite2 star21)
	(supports instrument8 thermograph0)
	(supports instrument8 image1)
	(supports instrument8 spectrograph2)
	(calibration_target instrument8 groundstation1)
	(on_board instrument8 satellite3)
	(power_avail satellite3)
	(pointing satellite3 star41)
	(supports instrument9 image1)
	(supports instrument9 thermograph0)
	(supports instrument9 spectrograph2)
	(calibration_target instrument9 groundstation2)
	(supports instrument10 spectrograph2)
	(supports instrument10 thermograph0)
	(supports instrument10 image1)
	(calibration_target instrument10 star0)
	(on_board instrument9 satellite4)
	(on_board instrument10 satellite4)
	(power_avail satellite4)
	(pointing satellite4 planet19)
)
(:goal
	(and
		
		(have_image phenomenon4 thermograph0)
		(have_image star5 thermograph0)
		(have_image phenomenon6 thermograph0)
		(have_image planet7 thermograph0)
		(have_image planet8 thermograph0)
		(have_image star9 thermograph0)
		(have_image star10 thermograph0)
		(have_image planet13 spectrograph2)
		(have_image planet14 spectrograph2)
		(have_image star15 thermograph0)
		(have_image phenomenon17 thermograph0)
		(have_image phenomenon18 thermograph0)
		(have_image planet19 spectrograph2)
		(have_image star21 thermograph0)
		(have_image planet22 image1)
		(have_image planet23 spectrograph2)
		(have_image planet24 thermograph0)
		(have_image phenomenon25 image1)
		(have_image planet27 thermograph0)
		(have_image phenomenon28 thermograph0)
		(have_image phenomenon29 image1)
		(have_image star30 spectrograph2)
		(have_image planet31 spectrograph2)
		(have_image phenomenon32 thermograph0)
		(have_image star33 image1)
		(have_image planet34 image1)
		(have_image phenomenon35 image1)
		(have_image star36 spectrograph2)
		(have_image planet37 thermograph0)
		(have_image planet38 image1)
		(have_image planet39 image1)
		(have_image phenomenon40 thermograph0)
		(have_image star41 image1)
		(have_image planet42 spectrograph2)
	)
)
)
