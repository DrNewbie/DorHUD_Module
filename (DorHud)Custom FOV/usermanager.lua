core:module("UserManager")
core:import("CoreEvent")
core:import("CoreTable")

_CUSTOMFOV_ManaUser_get_setting = _CUSTOMFOV_ManaUser_get_setting or GenericUserManager.get_setting

function GenericUserManager:get_setting(name)
	if name == "fov_zoom" or name == "fov_standard" then
		local PlyStandard = managers.player and managers.player:player_unit() and managers.player:player_unit():movement() and managers.player:player_unit():movement()._states.standard or nil
		if PlyStandard then
			local fov = _CUSTOMFOV_ManaUser_get_setting(self, name)
			local fov_multiplier = tonumber(tostring(DorHUD:conf('PDTH_CustomFOV_fov_multiplier'))) or 1.0
			if PlyStandard._equipped_unit and PlyStandard._equipped_unit.base then
				if PlyStandard._in_steelsight then
					fov_multiplier = 1 + (fov_multiplier - 1) / 2
				end
			end
			return fov * fov_multiplier
		end
	end	
	return _CUSTOMFOV_ManaUser_get_setting(self, name)
end