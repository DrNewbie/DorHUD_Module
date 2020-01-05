local module = ... or DorHUD:module('add_more_bonus')

module:add_menu_option("M_"..Idstring("add_more_bonus"):key(), {
	type = "multi_choice",
	text_id = "debug_add_more_bonus_name_id",
	choices = {
		{"disable", "debug_add_more_bonus_none"},
		{"medic_2x", "debug_add_more_bonus_medic_2x"},
		{"ammo_2x", "debug_add_more_bonus_ammo_2x"},
		{"engineer", "debug_add_more_bonus_engineer"},
		{"boomer", "debug_add_more_bonus_boomer"}
	},
	default_value = "disable",
	help_id = "debug_add_more_bonus_help_id"
})