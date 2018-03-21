/datum/role/revolutionary
	name = REV
	id = REV
	logo_state = "rev-logo"

/datum/role/revolutionary/Greet(var/greeting,var/custom)
	if(!greeting)
		return

	var/icon/logo = icon('icons/logos.dmi', logo_state)
	switch(greeting)
		if ("roundstart")
			to_chat(antag.current, {"<img src='data:image/png;base64,[icon2base64(logo)]' style='position: relative; top: 10;'/><span class = 'notice'>You are a member of the revolutionaries' leadership!</span>"})
		if ("admintoggle")
			to_chat(antag.current, "<img src='data:image/png;base64,[icon2base64(logo)]' style='position: relative; top: 10;'/> <span class='warning'>You suddenly feel rather annoyed with this stations leadership!</span>")
		if ("custom")
			to_chat(antag.current, "<img src='data:image/png;base64,[icon2base64(logo)]' style='position: relative; top: 10;'/> <span class='warning'>[custom]</span>")

	to_chat(antag.current, "<span class='info'><a HREF='?src=\ref[antag.current];getwiki=[wikiroute]'>(Wiki Guide)</a></span>")

/datum/role/revolutionary/New()
	..()
	wikiroute = role_wiki[ROLE_REV]

/datum/role/revolutionary/leader
	name = HEADREV
	id = HEADREV
	logo_state = "rev_head-logo"

/datum/role/revolutionary/leader/OnPostSetup()
	.=..()
	if(!.)
		return
	var/mob/living/carbon/human/mob = antag.current
	var/obj/item/device/flash/rev/T = new(mob)
	if(istype(mob))
		var/list/slots = list (
			"backpack" = slot_in_backpack,
			"left pocket" = slot_l_store,
			"right pocket" = slot_r_store,
		)
		var/where = mob.equip_in_one_of_slots(T, slots, put_in_hand_if_fail = 1)

		if (!where)
			to_chat(mob, "\The [faction.name] were unfortunately unable to get you \a [T].")
		else
			to_chat(mob, "\The [T] in your [where] will help you to persuade the crew to join your cause.")
	else
		T.forceMove(get_turf(mob))
		to_chat(mob, "\The [faction.name] were able to get you \a [T], but could not find anywhere to slip it onto you, so it is now on the floor.")