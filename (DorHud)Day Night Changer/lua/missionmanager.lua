local module = ... or DorHUD:module('DayNightChanger')

core:import("CoreMissionManager")
core:import("CoreClass")
MissionManager = MissionManager or class(CoreMissionManager.MissionManager)

if not MissionManager then
	return
end

local old_init = MissionManager.init

function MissionManager:init(...)
	old_init(self, ...)
	if Global.game_settings.level_id then
		local menu_id = "M_"..Idstring("day_night_chager_for_heist_"..Global.game_settings.level_id):key()
		if DorHUD:conf(menu_id) then
			local environment_name
			if DorHUD:conf(menu_id) == "Day" then
			elseif DorHUD:conf(menu_id) == "Night_L4D" then
			elseif DorHUD:conf(menu_id) == "Night_Diamnod" then
			else			
			end
		end
	end
end