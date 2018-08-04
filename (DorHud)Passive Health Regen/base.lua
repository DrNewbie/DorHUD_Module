local module = DorHUDMod:new("Passive Health Regen", { abbr = "PassiveHealthRegen",
	author = " ", bundled = true, description = {
		english = "Boom"
	}
})
module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")
return module
