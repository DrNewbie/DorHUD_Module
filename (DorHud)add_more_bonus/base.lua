local module = DMod:new("add_more_bonus", {
	abbr = "addmorebonus",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/26331/",
	version = "1"
})

module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

module:register_include("modlocalization", { type = "localization" })

module:register_include("modoptions", { type = "menu_options", lazy_load = true })

return module