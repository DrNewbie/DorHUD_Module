local module = DorHUDMod:new("Free Flight Camera", { abbr = "FreeFlightCamera",
	author = "Luffy, Dr_Newbie", bundled = true, description = {
		english = "Free Flight Camera"
	}
})
module:hook_post_require("lib/setups/gamesetup", "CameraBase")
return module
