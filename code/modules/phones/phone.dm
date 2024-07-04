/obj/machinery/phone
	name = "Wall Phone"
	icon = 'icons/obj/machines/phones.dmi'
	icon_state = "wall_phone"
	// Standardized Health
	health_max = 100

	var/picked_up = FALSE
	var/ringing = FALSE
	var/extention = 0

/obj/machinery/phone/Initialize()
	. = ..()

/obj/machinery/phone/Destroy()
	. = ..()
