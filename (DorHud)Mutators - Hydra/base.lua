local module = DorHUDMod:new("Mutators - Hydra", { abbr = "MutatorsHydra",
	author = " ", bundled = true, description = {
		english = "Boom"
	}
})

module:hook_post_require("lib/units/enemies/cop/copdamage", "copdamage")
module:hook_post_require("lib/units/civilians/civiliandamage", "civiliandamage")

module:add_config_option("mutatorshydra_split_amount", 2.0)
module:add_config_option("mutatorshydra_max_split_times", 2.0)
module:add_config_option("mutatorshydra_civilian_killed_bonus", false)

module:register_include("modoptions", { type = "menu_options", lazy_load = true })
module:register_include("modlocalization", { type = "localization" })

return module
