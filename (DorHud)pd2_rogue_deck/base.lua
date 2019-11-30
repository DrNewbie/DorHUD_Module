local module = DMod:new("pd2_rogue_deck", {
	abbr = "pdroguedeck",
	author = "Dr_Newbie",
	description = "http://modwork.shop/26078",
	version = "1"
})

module:hook_post_require("lib/units/beings/player/playerdamage", "playerdamage")

module:hook_post_require("lib/tweak_data/upgradestweakdata", "upgradestweakdata")

module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

return module