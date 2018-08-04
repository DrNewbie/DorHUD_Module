local module = DorHUDMod:new("Custom FOV", { abbr = "PDTH_CustomFOV",
	author = " ", bundled = true, description = {
		english = "Boom"
	}
})

module:hook_post_require("lib/units/cameras/fpcameraplayerbase", "fpcameraplayerbase")

module:hook_post_require("lib/managers/usermanager", "usermanager")

module:add_config_option("PDTH_CustomFOV_fov_multiplier", 1.0)

module:register_include("modoptions", { type = "menu_options", lazy_load = true })

module:register_include("modlocalization", { type = "localization" })

return module
