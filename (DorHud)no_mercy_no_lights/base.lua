local module = DMod:new("no_mercy_no_lights", {
	abbr = "nonercynolights",
	author = "Dr_Newbie",
	description = "http://modwork.shop/26114",
	version = "1"
})

module:hook_post_require("lib/managers/mission/missionscriptelement", "missionscriptelement")

return module