local module = ... or DorHUD:module('DayNightChanger')

for lv_id, name_id in pairs(
		{
			["bank"] = "debug_bank",
			["heat_street"] = "debug_street",
			["bridge"] = "debug_bridge",
			["diamond_heist"] = "debug_diamond_heist",
			["slaughter_house"] = "debug_slaughter_house",
			["hospital"] = "debug_hospital",			
			["apartment"] = "debug_apartment",			
			["suburbia"] = "debug_suburbia",
			["secret_stash"] = "debug_secret_stash"
		}
	) do
	module:add_menu_option("M_"..Idstring("day_night_chager_for_heist_"..lv_id):key(), {
		type = "multi_choice",
		text_id = name_id,
		choices = {
			{"Default", "daynight_loc_on_default"},
			{"Day", "daynight_loc_on_day"},
			{"Night_Diamnod", "daynight_loc_on_night_diamnod"},
			{"Night_L4D", "daynight_loc_on_night_hospital"}
		},
		default_value = "Default"
	})
end