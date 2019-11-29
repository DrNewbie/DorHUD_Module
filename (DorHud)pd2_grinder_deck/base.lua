local module = DMod:new("pd2_grinder_deck", {
	abbr = "pdgrinderdeck",
	author = "Dr_Newbie",
	description = "http://modwork.shop/26072",
	version = "1"
})

module:hook_post_require("lib/units/beings/player/playerdamage", "playerdamage")

module:hook_post_require("lib/tweak_data/upgradestweakdata", "upgradestweakdata")

module:hook_post_require("lib/managers/playermanager", "playermanager")

module:hook_post_require("lib/units/enemies/cop/copdamage", "copdamage")

module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

return module