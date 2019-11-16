local module = ... or D:module('pd2_ace_inspire')
local PlayerStandard = module:hook_class("PlayerStandard")

module:hook(PlayerStandard, "_check_action_inspire", function(self, t)
	if self._intimidate_t and t - self._intimidate_t <= 0.5 then
		return
	end

	if not alive(self._unit) or not self._unit:movement() then
		return
	end

	local current_state_name = self._unit:movement():current_state_name()
	if current_state_name ~= "standard" then
		return
	end

	local rally_skill_data = self._ext_movement:rally_skill_data()
	if not rally_skill_data or not rally_skill_data.long_dis_revive or rally_skill_data.long_dis_revive_delay_t >= t then
		return
	end

	local revived_unit = nil
	local criminals = managers.groupai:state():all_criminals()
	for u_key, u_data in pairs(criminals) do
		local unit = u_data.unit
		if alive(unit) and unit:movement() then
			if mvector3.distance_sq(self._pos, unit:movement():m_pos()) < rally_skill_data.range_sq then
				local cam_fwd = self._unit:camera():forward()
				local vec = unit:movement():m_pos() - self._pos
				local dis = mvector3.normalize(vec)
				local max_angle = math.max(8, math.lerp(10, 30, dis / 1200))
				local angle = vec:angle(cam_fwd)
				if angle < max_angle or math.abs(max_angle - angle) < 10 then
					local interaction_ext = unit:interaction()
					if interaction_ext and interaction_ext:active() then -- ?
						interaction_ext:interact(self._unit)
						interaction_ext:interact_interupt(self._unit)
						revived_unit = unit
					else
						local dmg_ext = unit:character_damage()
						if dmg_ext then
							local needs_revive = false
							if dmg_ext.need_revive then
								needs_revive = dmg_ext:need_revive() and not dmg_ext:arrested()
							elseif dmg_ext.incapacitated then
								needs_revive = dmg_ext:incapacitated()
							end

							if needs_revive then
								dmg_ext:revive(self._unit)
								revived_unit = unit
							end
						end
					end
					if revived_unit then
						self._ext_movement:rally_skill_data().long_dis_revive_delay_t = t + rally_skill_data.long_dis_revive_cooldown_t
						self._intimidate_t = t + 0.5
						self:say_line("e01x_sin")
						self:_play_distance_interact_redirect(t, "cmd_point")
						break
					end
				end				
			end
		end
	end

	return revived_unit
end, true)

module:hook(PlayerStandard, "_start_action_intimidate", function(self, ...)
	if self:_check_action_inspire(...) then
		return true
	end
	return module:call_orig(PlayerStandard, "_start_action_intimidate", self, ...)
end, true)