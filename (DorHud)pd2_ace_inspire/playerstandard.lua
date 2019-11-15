local module = ... or DMod:module('pd2_ace_inspire')

local PlayerStandard = module:hook_class("PlayerStandard")

module:pre_hook(PlayerStandard, "_start_action_intimidate", function(self, _t_now)
	if not self._intimidate_t or _t_now - self._intimidate_t > 0.5 then
		if self._unit and self._unit:movement() then
			local current_state_name = self._unit:movement():current_state_name()
			if current_state_name ~= "arrested" and current_state_name ~= "bleed_out" and current_state_name ~= "fatal" and current_state_name ~= "incapacitated" then
				local rally_skill_data = self._ext_movement:rally_skill_data()
				if rally_skill_data and rally_skill_data.long_dis_revive_delay_t < _t_now then
					local r_unit = nil
					local criminals = managers.groupai:state():all_criminals()
					for u_key, u_data in pairs(criminals) do
						if u_data.unit and u_data.unit:movement() then
							if mvector3.distance_sq(self._pos, u_data.unit:movement():m_pos()) < rally_skill_data.range_sq then
								local cam_fwd = self._unit:camera():forward()
								local vec = u_data.unit:movement():m_pos() - self._pos
								local dis = mvector3.normalize(vec)
								local max_angle = math.max(8, math.lerp(10, 30, dis / 1200))
								local angle = vec:angle(cam_fwd)
								if angle < max_angle or math.abs(max_angle-angle) < 10 then
									r_unit = u_data.unit
									if r_unit:interaction() and r_unit:interaction():active() then
										r_unit:interaction():interact(self._unit)
										r_unit:interaction():interact_interupt(self._unit)	
									elseif r_unit:character_damage() and r_unit:character_damage():need_revive() and not r_unit:character_damage():arrested() then
										r_unit:character_damage():revive(self._unit)
									else
										r_unit = nil
									end
									if r_unit then
										self._ext_movement:rally_skill_data().long_dis_revive_delay_t = _t_now + rally_skill_data.long_dis_revive_cooldown_t
										self._intimidate_t = _t_now + 0.5
										self:say_line("e01x_sin")
										self:_play_distance_interact_redirect(_t_now, "cmd_point")
										break
									end
								end				
							end
						end
					end
				end
			end
		end
	end
end, false)