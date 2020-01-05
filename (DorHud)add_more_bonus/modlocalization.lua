local module = ... or DorHUD:module('add_more_bonus')

module:add_localization_string("debug_add_more_bonus_name_id", {
	english = "More Bonus"
})

module:add_localization_string("debug_add_more_bonus_help_id", {
	english = table.concat({
		"[Combat Doctor]",
		"You gain 1 addition Doctor Bags.\n",
		"[Extra Lead]",
		"You gain 1 addition Ammo Bags.\n"
	}, "\n")
})

module:add_localization_string("debug_add_more_bonus_none", {
	english = "Disable"
})

module:add_localization_string("debug_add_more_bonus_medic_2x", {
	english = "Combat Doctor"
})

module:add_localization_string("debug_add_more_bonus_medic_2x_desc", {
	english = "You gain 1 addition Doctor Bags."
})

module:add_localization_string("debug_add_more_bonus_ammo_2x", {
	english = "Extra Lead"
})

module:add_localization_string("debug_add_more_bonus_ammo_2x_desc", {
	english = "You gain 1 addition Ammo Bags."
})