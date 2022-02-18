local module = DMod:new("pd2_shockproof", {
	abbr = "pd2_shockproof",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/36341",
	version = "1"
})

module:hook_post_require("lib/units/beings/player/states/playertased", "playertased")

return module