local module = DMod:new("pd2_anarchist_deck", {
	abbr = "pdanarchistdeck",
	author = "Dr_Newbie",
	description = "http://modwork.shop/26077",
	version = "1"
})

module:hook_post_require("lib/units/beings/player/playerdamage", "playerdamage")

module:hook_post_require("lib/tweak_data/upgradestweakdata", "upgradestweakdata")

module:hook_post_require("lib/units/enemies/cop/copdamage", "copdamage")

module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

return module