local module = DMod:new("weapon_selection_unlock", {
	abbr = "weaponselectionunlock",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/",
	version = "1"
})

module:hook_post_require("lib/managers/menu/items/menuitemkitslot", "menuitemkitslot")

module:hook_post_require("lib/units/beings/player/playerinventory", "playerinventory")

module:hook_post_require("lib/managers/playermanager", "playermanager")

return module