local module = DMod:new("pd2_armorer_deck", {
	abbr = "pdarmorerdeck",
	author = "Dr_Newbie",
	description = "http://modwork.shop/26195",
	version = "1"
})

module:hook_post_require("lib/units/beings/player/playerdamage", "playerdamage")

module:hook_post_require("lib/tweak_data/upgradestweakdata", "upgradestweakdata")

module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

return module