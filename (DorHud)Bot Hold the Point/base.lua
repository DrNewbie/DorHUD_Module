local module = DorHUDMod:new("Bot Hold the Point", { abbr = "BotHoldPoint",
	author = "Dr_Newbie", bundled = true, description = {
		english = "Boom"
	}
})

module:hook_post_require("lib/units/player_team/teamaimovement", "lua/teamaimovement.lua")

module:add_menu_option("bot_hold_the_point_key", {
	type = "keybind",
	name = {
		english = "Keybind to Ask"
	}
})

local function AskBotHoldthePoint()
	if not managers.criminals or not managers.groupai or not managers.player then
		return
	end
	local ply_unit = managers.player:player_unit()
	if not ply_unit or not alive(ply_unit) then
		return
	end
	local PlyStandard = ply_unit:movement() and ply_unit:movement()._states.standard
	if not PlyStandard then
		return
	end
	local cam_fwd = ply_unit:camera():forward()
	for u_key, ai in pairs(managers.groupai:state():all_AI_criminals()) do
		if ai.unit and ai.unit:movement() and ai.unit:movement().set_should_stay then
			local ai_pos = ai.unit:movement()._m_pos
			local vec = ai_pos - ply_unit:position()
			local dis = mvector3.normalize(vec)
			local max_angle = math.max(8, math.lerp(10, 30, dis / 1200))
			local angle = vec:angle(cam_fwd)					
			if angle < max_angle or math.abs(max_angle-angle) < 10 then
				ai.unit:movement():set_should_stay(not ai.unit:movement()._should_stay)
				if ai.unit:movement()._should_stay then
					PlyStandard:_do_action_intimidate(TimerManager:game():time(), "cmd_stop", "l01x_sin", false)
				else
					local static_data = managers.criminals:character_static_data_by_unit(ai.unit)
					if static_data then
						local character_code = static_data.ssuffix
						PlyStandard:_do_action_intimidate(TimerManager:game():time(), "cmd_come", "f21" .. character_code .. "_sin", false)
					end
				end
				break
			end
		end
	end
end

module:hook("OnKeyPressed", "bot_hold_the_point_key", nil, "GAME", function()
	AskBotHoldthePoint()
end)

return module
