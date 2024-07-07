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


/obj/machinery/phone/proc/sound_in(message)
	to_world("You said [message]")

/obj/item/device/handset
	name = "Handset"
	icon = 'icons/obj/machines/phones.dmi'
	icon_state = "handset"

/obj/item/device/handset/talk_into(mob/living/M, message, channel, verb = "says", datum/language/speaking = null)
	to_world("You said [message]")
