local module = DMod:new("m308_be_sniper_rifle", {
	abbr = "m308sniper",
	author = "Dr_Newbie",
	description = "http://modwork.shop/21108",
	version = "2"
})

module:hook_post_require("lib/tweak_data/weapontweakdata", "weapontweakdata")
module:hook_post_require("lib/units/weapons/raycastweaponbase", "raycastweaponbase")
module:hook_post_require("lib/managers/gameplaycentralmanager", "gameplaycentralmanager")

return module
