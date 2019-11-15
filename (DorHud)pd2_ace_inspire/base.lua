local module = DMod:new("pd2_ace_inspire", {
	abbr = "pdinspire",
	author = "Dr_Newbie",
	description = "http://modwork.shop/25993",
	version = "1"
})

module:hook_post_require("lib/units/beings/player/playermovement", "playermovement")

module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

return module