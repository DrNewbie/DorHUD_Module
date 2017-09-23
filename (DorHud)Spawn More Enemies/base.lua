local module = DorHUDMod:new("Spawn More Enemies", { abbr = "SpawnMoreEnemies",
	author = "Dr_Newbie", bundled = true, description = {
		english = "Boom"
	}
})
module:hook_post_require("lib/managers/mission/elementspecialobjective", "elementspecialobjective")
module:hook_post_require("lib/managers/group_ai_states/groupaistatebesiege", "groupaistatebesiege")
module:hook_post_require("lib/managers/group_ai_states/groupaistatestreet", "groupaistatestreet")
module:hook_post_require("lib/managers/group_ai_states/groupaistatebase", "groupaistatebase")
module:hook_post_require("lib/managers/mission/elementspawnenemydummy", "elementspawnenemydummy")
module:hook_post_require("lib/managers/mission/elementspawnenemygroup", "elementspawnenemygroup")
return module
