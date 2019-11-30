local module = DMod:new("heavy_security", {
	abbr = "hhheavy_security",
	author = "Dr_Newbie",
	description = "http://modwork.shop/26082",
	version = "1"
})

module:hook_post_require("lib/managers/mission/elementspawnenemydummy", "elementspawnenemydummy")

module:add_config_option("heavy_security_level", 1)

module:register_include("modoptions", { type = "menu_options", lazy_load = true })

module:register_include("modlocalization", { type = "localization" })

return module