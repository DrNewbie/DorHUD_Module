local module = DorHUDMod:new("Passive Health Regen", { abbr = "PassiveHealthRegen",
	author = "Schmuddel", bundled = true, description = {
		english = "http://modwork.shop/19376"
	}
})
module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")
return module
