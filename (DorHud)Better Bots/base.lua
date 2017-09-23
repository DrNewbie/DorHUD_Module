local module = DorHUDMod:new("Better Bots", { abbr = "BetterBots",
	author = "Schmuddel", bundled = true, description = {
		english = "http://modwork.shop/19324"
	}
})
module:hook_post_require("lib/managers/criminalsmanager", "criminalsmanager")
module:hook_post_require("lib/managers/group_ai_states/groupaistatebase", "groupaistatebase")
module:hook_post_require("lib/units/player_team/teamaidamage", "teamaidamage")
module:hook_post_require("lib/units/weapons/raycastweaponbase", "raycastweaponbase")
module:hook_post_require("lib/managers/navigationmanager", "navigationmanager")
module:hook_post_require("lib/units/player_team/logics/teamailogicassault", "teamailogicassault")
module:hook_post_require("lib/units/player_team/logics/teamailogicidle", "teamailogicidle")
module:hook_post_require("lib/units/player_team/logics/teamailogictravel", "teamailogictravel")
return module
