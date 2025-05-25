//contains code for the crystal module, rocks found on lavaland. this could probably be in the mining section, but hey

/obj/item/crystal
	name = "default crystal"
	desc = "The basic form of all crystals. You shouldn't be seeing this."
	icon = 'icons/obj/crystals.dmi'
	icon_state = "debug"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = LAVA_PROOF

/obj/item/magma_oyster
	name = "magma oyster"
	desc = "A magma oyster. They bury themselves in the ash near magma lakes, and filter the molten rock for flecks of minerals at high tide."
	icon = 'icons/obj/crystals.dmi'
	icon_state = "debug"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = LAVA_PROOF

/turf/open/floor/plating/asteroid/basalt/getDug()
	var/list/adjacent_turfs = get_adjacent_open_turfs(src)
	for(var/turf/open/T in adjacent_turfs)
		if(prob(100) && istype(T, /turf/open/lava))
			new /obj/item/magma_oyster(src)
	. = ..()

/obj/item/magma_oyster/attackby(obj/item/W, mob/user, params)
	if(W.is_sharp())
		playsound(loc, 'sound/weapons/slice.ogg', 50, 1, -1)
		user.visible_message("[user] wedges their blade into \the [src].", span_notice("You start removing the shell from \the [src]..."), span_italics("You hear the sound of cracking bone."))
		if(do_after(user, 50, target = src))
			to_chat(user, span_notice("You crack open \the [src]."))
			new /obj/item/crystal/pearl(user.drop_location())
			qdel(src)
	else
		return ..()

/obj/item/crystal/pearl
	name = "magma pearl"
	desc = "A magmatic pearl, pulled from the mouth of a magma oyster. It glimmers with a dull, orange light."
	icon_state = "debug"

/obj/item/crystal/orange
	name = "orange"
	desc = "On closer inspection, this orange is actually a crystal, perfectly resembling an orange!"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "orange"
