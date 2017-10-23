local module = DorHUDMod:new("M308 as a Sniper Rifle", { abbr = "M308_SniperRifle",
	author = "Dr_Newbie", bundled = true, description = {
		english = " "
	}
})
module:hook_post_require("lib/tweak_data/tweakdata", "tweakdata")
module:hook_post_require("lib/units/weapons/raycastweaponbase", "raycastweaponbase")
module:hook_post_require("lib/managers/gameplaycentralmanager", "gameplaycentralmanager")
return module
