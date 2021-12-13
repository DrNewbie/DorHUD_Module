local module = DMod:new("test_place", {
	abbr = "testmap",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/35454",
	version = "3"
})

--[[Localization]]
module:register_include("modlocalization", {type = "localization"})

--[[Block Event]]
module:hook_post_require("lib/managers/achievmentmanager", "block_event/achievmentmanager")
module:hook_post_require("lib/managers/challengesmanager", "block_event/challengesmanager")
module:hook_post_require("lib/managers/mission/elementspawncivilian", "block_event/elementspawncivilian")
module:hook_post_require("lib/managers/mission/elementspawnenemydummy", "block_event/elementspawnenemydummy")
module:hook_post_require("lib/managers/mission/elementspawnciviliangroup", "block_event/elementspawnciviliangroup")
module:hook_post_require("lib/managers/mission/elementspawnenemygroup", "block_event/elementspawnenemygroup")
module:hook_post_require("lib/managers/mission/elementwaypoint", "block_event/elementwaypoint")
module:hook_post_require("lib/managers/mission/elementobjective", "block_event/elementobjective")
module:hook_post_require("lib/managers/mission/elementhint", "block_event/elementhint")
module:hook_post_require("lib/managers/mission/elementdialogue", "block_event/elementdialogue")
module:hook_post_require("lib/managers/mission/missionscriptelement", "block_event/missionscriptelement")

--[[Mod Event]]
module:hook_post_require("lib/managers/mission/missionscriptelement", "mod_event/missionscriptelement")
--module:hook_post_require("lib/managers/missionmanager", "mod_event/missionmanager")

--[[Add 'TEST']]
module:hook_post_require("lib/managers/menu/menunodegui", "menunodegui")

--[[Get 'XYZ']]
--module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

module.__allow_heist = {
	apartment = "apartment"
}

module.is_this_level_ok = function()
	if Global and Global.game_settings and Global.game_settings.single_player and Global.game_settings.level_id and module.__allow_heist[Global.game_settings.level_id] then
		return module.__allow_heist[Global.game_settings.level_id]
	end
	return false
end

return module