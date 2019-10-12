local module = DorHUDMod:new("Day Night Changer", { abbr = "DayNightChanger",
	author = "Dr_Newbie", bundled = true, description = {
		english = "http://modwork.shop/25740"
	}
})
module:hook_post_require("core/lib/utils/dev/editor/coreworlddefinition", "lua/core.coreworlddefinition.lua")
module:hook_post_require("lib/managers/missionmanager", "lua/missionmanager.lua")
module:register_include("menu/modlocalization", { type = "localization" })
module:register_include("menu/modoptions", { type = "menu_options", lazy_load = true })

if PackageManager then
	if not Global.game_settings or not Global.game_settings.level_id or not game_state_machine or not string.find(game_state_machine:current_state_name(), "game") then
		if PackageManager:loaded("levels/suburbia/world") then
			PackageManager:unload("levels/suburbia/world")
		end
		if PackageManager:loaded("levels/l4d/world") then
			PackageManager:unload("levels/l4d/world")
		end
		if PackageManager:loaded("levels/diamondheist/world") then
			PackageManager:unload("levels/diamondheist/world")
		end
	end
end

return module