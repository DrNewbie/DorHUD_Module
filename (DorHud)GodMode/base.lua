local module = DorHUDMod:new("GodMode", { abbr = "GodMode",
	author = "Dr_Newbie", bundled = true, description = {
		english = "Enable God Mode"
	}
})
module:hook_post_require("lib/units/beings/player/playerdamage", "playerdamage")
return module
