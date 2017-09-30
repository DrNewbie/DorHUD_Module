local module = DorHUDMod:new("Stockholm Syndrome", { abbr = "StockholmSyndrome",
	author = "Dr_Newbie", bundled = true, description = {
		english = "Boom"
	}
})
module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")
return module
