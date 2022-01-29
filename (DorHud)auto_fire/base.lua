local module = DMod:new("auto_fire", {
	abbr = "autofire",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/36060",
	version = "1"
})

module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

return module