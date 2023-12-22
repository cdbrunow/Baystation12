/obj/overmap/visitable/ship/landable/bumblebee
	name = "SFS Bumble Bee"
	desc = "A small agile shuttle designed for fast maneuvers"
	shuttle = "Bumble Bee"
	fore_dir = WEST
	color = "#001e70"
	vessel_mass = 750
	vessel_size = SHIP_SIZE_TINY

/obj/machinery/computer/shuttle_control/explore/sfv_bumblebee
	name = "landing control console"
	shuttle_tag = "SFV BumbleBee"

/datum/shuttle/autodock/overmap/sfv_bumblebee
	name = "SFV BumbleBee"
	warmup_time = 5
	move_time = 15
	shuttle_area = list()
	current_location = "nav_hangar_tempeterra"
	landmark_transition = "nav_transit_bumblebee"
	range = 1
	fuel_consumption = 2
	ceiling_type = /turf/simulated/floor/shuttle_ceiling
	flags = SHUTTLE_FLAGS_PROCESS | SHUTTLE_FLAGS_ZERO_G
	defer_initialisation = FALSE


/obj/shuttle_landmark/bumblebee
	name = "TempeTerra Hangar"
	landmark_tag = "nav_hangar_tempeterra"
	base_area = /area/tempeterra/hangar
	base_turf = /turf/simulated/floor/plating
