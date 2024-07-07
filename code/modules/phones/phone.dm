/obj/machinery/phone
	name = "Wall Phone"
	icon = 'icons/obj/machines/phones.dmi'
	icon_state = "wall_phone"
	// Standardized Health
	health_max = 100

	var/picked_up = FALSE
	var/ringing = FALSE
	var/extention = 0

	var/obj/item/device/handset/attached

/obj/machinery/phone/Initialize()
	. = ..()
	attached = new /obj/item/device/handset(src)
	attached.attached = src

/obj/machinery/phone/Destroy()
	qdel(attached)
	. = ..()

/obj/machinery/phone/Process()
	. = ..()


/obj/machinery/phone/use_tool(obj/item/device/T, mob/living/user, list/click_params)
	. = ..()
	if(istype(T,/obj/item/device/handset))
		//STOP_PROCESSING(SSobj, src)
		recall_phone()

/obj/machinery/phone/proc/recall_phone()
	if(ismob(attached.loc))
		var/mob/living/carbon/human/H = attached.loc
		H.drop_from_inventory(attached)
		attached.loc = src
		playsound(attached, 'sound/obj/item/phone/SetDown.ogg', 90)
		icon_state = "wall_phone"
		update_icon()

/obj/machinery/phone/proc/sound_in(message)
	to_world("You said [message] into the phone!")

/obj/machinery/phone/attack_hand(mob/living/carbon/human/M)
	playsound(attached, 'sound/obj/item/phone/PickedUp.ogg', 90)
	//sleep(750)
	playsound(attached, 'sound/obj/item/phone/DialToneThreeSec.mp3', 50)
	M.put_in_active_hand(attached)
	icon_state = "wall_phone_ear"
	update_icon()


/obj/item/device/handset
	name = "Handset"
	icon = 'icons/obj/machines/phones.dmi'
	icon_state = "handset"
	var/obj/machinery/phone/attached


/obj/item/device/handset/Initialize(phonesrc)
	. = ..()

/obj/item/device/handset/talk_into(mob/living/M, message, channel, verb = "says", datum/language/speaking = null)
	to_world("You said [message] into the handset!")
	attached.sound_in(message)
