local module = DMod:new("Receive Double Damage", {
	abbr = "Get2xHurt",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/46058",
	version = "2"
})

module:hook_post_require("lib/units/beings/player/playerdamage", "playerdamage")
return module
