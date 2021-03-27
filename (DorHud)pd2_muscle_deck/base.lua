local module = DMod:new("pd2_muscle_deck", {
	abbr = "pdmuscledeck",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/27990",
	version = "3"
})

module:hook_post_require("lib/units/beings/player/playerdamage", "playerdamage")

module:hook_post_require("lib/tweak_data/upgradestweakdata", "upgradestweakdata")

module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

return module