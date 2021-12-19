local module = DMod:new("isolation_helper", {
	abbr = "isolationhelper",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/35522",
	version = "1"
})

module:hook_post_require("lib/managers/mission/missionscriptelement", "missionscriptelement")

module.WPON = function()
	if managers.hud and module.SAW_Position then
		managers.hud:add_waypoint("l4d_IsolationRoomHelper", {
			text = "Cut this",
			icon = "wp_saw",
			position = module.SAW_Position,
			distance = true
		})
	end
	return
end

module.WPOFF = function()
	if managers.hud then
		managers.hud:remove_waypoint("l4d_IsolationRoomHelper")
	end
	return
end

module.is_this_level_ok = function()
	if Global and Global.game_settings and tostring(Global.game_settings.level_id) == "hospital" then
		return true
	end
	return false
end

return module