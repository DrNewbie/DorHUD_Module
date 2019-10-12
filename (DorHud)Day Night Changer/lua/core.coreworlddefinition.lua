local module = ... or DorHUD:module('DayNightChanger')

core:module("CoreWorldDefinition")
core:import("CoreUnit")
core:import("CoreMath")
core:import("CoreEditorUtils")
core:import("CoreEngineAccess")
WorldDefinition = WorldDefinition or class()

if not WorldDefinition then
	return
end

local old_create_environment = WorldDefinition._create_environment

function WorldDefinition:_create_environment(...)
	old_create_environment(self, ...)
	if Global.game_settings.level_id then
		local menu_id = "M_"..Idstring("day_night_chager_for_heist_"..Global.game_settings.level_id):key()
		if DorHUD:conf(menu_id) then
			local environment_name
			if DorHUD:conf(menu_id) == "Day" then
				if not PackageManager:loaded("levels/suburbia/world") then
					PackageManager:load("levels/suburbia/world")
				end
				environment_name = "environments/env_suburbia/env_suburbia"
			elseif DorHUD:conf(menu_id) == "Night_L4D" then
				if not PackageManager:loaded("levels/l4d/world") then
					PackageManager:load("levels/l4d/world")
				end
				environment_name = "environments/env_l4d/env_l4d"
			elseif DorHUD:conf(menu_id) == "Night_Diamnod" then
				if not PackageManager:loaded("levels/diamondheist/world") then
					PackageManager:load("levels/diamondheist/world")
				end
				environment_name = "environments/env_diamond2/env_diamond2"
			else
			
			end
			if environment_name then
				managers.viewport:preload_environment(environment_name)
				managers.environment_area:set_default_environment(environment_name, nil, nil)
			end
		end
	end
end