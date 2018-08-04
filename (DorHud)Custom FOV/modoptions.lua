local module = ... or DorHUD:module('PDTH_CustomFOV')

module:set_default_menu_option_callback(PDTH_CustomFOV_option_changed)

module:add_menu_option("PDTH_CustomFOV_fov_multiplier", {type = "number", text_id = "PDTH_CustomFOV_fov_multiplier_Menu"})