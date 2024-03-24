/obj/item/gun/projectile/rocket
	name = "Lumoco Faithbreaker"
	desc = "Lumoco's Faithbreaker is a aptly named rocket-launcher commonly seen amongst poorer fighters and terrorists due to it's cheap and reusable nature."
	icon_state = "rocket"
	item_state = "rocket"
	icon = 'icons/obj/weapons/launchers.dmi'
	w_class = ITEM_SIZE_HUGE
	throw_speed = 2
	throw_range = 10
	caliber = CALIBER_ROCKET
	force = 5.0
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = 0
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 5)
	fire_sound = 'sound/weapons/gunshot/rpg_fire.ogg'
	combustion = 1
	max_shells = 1
	one_hand_penalty = 10
	handle_casings = HOLD_CASINGS
	ammo_type = /obj/item/ammo_casing/rocket
	var/windup = 5 // Rockets take half a second to prep to fire, set to zero to invalidate cmompletly.
	load_sound = 'sound/weapons/guns/interaction/rpg_reload.ogg'

/obj/item/gun/projectile/rocket/handle_post_fire(mob/user, atom/target)
	..()
	log_and_message_admins("fired a rocket from a rocket launcher ([src.name]) at [target].")

/obj/item/gun/projectile/rocket/afterattack(atom/A, mob/living/user, adjacent, params) // RPGs snowflake this due to windup, okay? Else ancient baycode gets angry and starts erroring.
	if(adjacent) return //A is adjacent, is the user, or is on the user's person

	if(!user.aiming)
		user.aiming = new(user)

	if(windup > 0)
		if(do_after(user, windup)) // Do the windup.
			Fire(A,user,params) //Otherwise, fire normally.
	else
		Fire(A,user,params) //Otherwise, fire normally.

/// Disposable RPG

/obj/item/gun/projectile/rocket/oneuse // One time use RPGs.
	slot_flags = SLOT_BACK|SLOT_BELT
	icon = 'icons/obj/weapons/launchers64.dmi' // RPG file for big boy RPGs.
	icon_state = "disposable_marine"
	 // As a note, you can technically reload these, but you need an admin to spawn you the ammo, which is better than having them spawn you the rocket THEN delete the old one.
	ammo_type = /obj/item/ammo_casing/oneuse_rocket
	ununloadable = TRUE
	var/folded = 1

//Unfolds/folds the RPG.
/obj/item/gun/projectile/rocket/oneuse/attack_self(mob/user)
	if(folded)
		playsound(src.loc,'sound/weapons/guns/interaction/rpgoneuse_deploying.ogg',80, 0)
		user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
		if(do_after(usr, 30, src))
			usr.visible_message("<span class='notice'>\The [usr] extends [src].</span>", "<span class='notice'>You deploy the [src]</span>")
			folded = FALSE
			icon_state = "[icon_state]_deployed"
			item_state = "[item_state]_deployed"
			slot_flags = null
	else
		playsound(src.loc,'sound/weapons/guns/interaction/rpgoneuse_deploying.ogg',80, 0)
		user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
		if(do_after(usr, 30, src))
			usr.visible_message("<span class='notice'>\The [usr] folds the [src].</span>", "<span class='notice'>You fold the [src]</span>")
			folded = TRUE
			icon_state = initial(icon_state)
			item_state = initial(item_state)
			slot_flags = SLOT_BACK|SLOT_BELT

// Tells the player to deploy it, dummy.
/obj/item/gun/projectile/rocket/oneuse/special_check(mob/user)
	if(folded)
		to_chat(user, "You can't fire this in this state! Deploy it!")
		return 0
	return ..()
