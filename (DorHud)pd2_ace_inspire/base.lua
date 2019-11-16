local module = DMod:new("pd2_ace_inspire", {
	abbr = "pdinspire",
	author = "Dr_Newbie",
	description = "http://modwork.shop/25993",
	version = "1.1"
})

module:hook_post_require("lib/units/beings/player/playermovement", "playermovement")
module:hook_post_require("lib/units/beings/player/states/playerstandard", "playerstandard")

module:add_menu_option(module:id() .. "_use_online", {
	type = "boolean", text_id = "Enable in multiplayer mode", localize = false, default_value = false
})

local use_online = false

local function toggle_inspire_state(enabled)
	module:log(3, "OnNetworkDataRecv_CheckEnableInspire", "inspire enabled:", enabled)
	module.enabled_in_lobby = enabled

	local player_unit = managers.player and managers.player:player_unit()
	if alive(player_unit) then
		local movement_ext = player_unit:movement()
		if movement_ext then
			movement_ext:rally_skill_data().long_dis_revive = enabled
		end
	end
end

module:hook("OnModuleLoading", "OnModuleLoading_SetEnableInspire", function(module)
	module.enabled_in_lobby = false

	if Network:is_server() then
		use_online = module:conf("use_online") -- can't change once started

		module.enabled_in_lobby = true
		module:hook("OnPeerAdded", "OnPeerAdded_CheckEnableInspire", function(peer)
			peer:add_callback(peer.SYNC_DONE_CALLBACK, function(peer)
				if use_online then
					if not peer:is_local_user() and peer:has_dmf() then
						DNet:send_to_peer(peer, "ModEvent", { module = module:id(), event = "EnableInspire" })
					end
				else
					-- disabled even when not spawned
					toggle_inspire_state(managers.network:session():amount_of_peers() == 1)
				end
			end)
		end)

		if not use_online then
			module:hook("OnPeerRemoved", "OnPeerRemoved_CheckEnableInspire", function(peer)
				toggle_inspire_state(managers.network:session():amount_of_peers() == 1)
			end)
		end
	end
end)

module:hook("OnNetworkDataRecv", "OnNetworkDataRecv_CheckEnableInspire", "ModEvent", function(peer, data_type, data)
	if not peer:is_server() or type(data) ~= "table" or data.event ~= "EnableInspire" then
		return
	end

	toggle_inspire_state(data.value ~= false)
end)

return module