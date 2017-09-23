local module = DorHUDMod:new("Special Rush", { abbr = "SpecialRush",
	author = "Dr_Newbie", bundled = true, description = {
		english = "Replace enemies with Special"
	}
})
module:hook_post_require("lib/tweak_data/groupaitweakdata", "groupaitweakdata")

module:add_config_option("specialrush_add_bulldozer", false)
module:add_config_option("specialrush_add_cloaker", false)
module:add_config_option("specialrush_add_tazer", false)
module:add_config_option("specialrush_add_shield", false)
module:add_config_option("specialrush_add_sniper", false)

module:register_include("modoptions", { type = "menu_options", lazy_load = true })
module:register_include("modlocalization", { type = "localization" })
return module
