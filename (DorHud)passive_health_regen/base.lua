local module = DorHUDMod:new("Passive Health Regen", { abbr = "Passive Health Regen",
	author = " ", bundled = true, description = {
		english = "Boom"
	}
})
module:hook_post_require("lib/units/beings/player/states/playerstandard", "passive_health_regen.lua")

return module