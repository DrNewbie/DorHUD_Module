	local old_update = PlayerStandard.update
	function PlayerStandard:update(t, dt)
		if true then
			local damage = self._unit:character_damage()
			if damage then
				if not damage:full_health() then
					if not damage:need_revive() then
						if not self._regen_t or self._regen_t <= 0 then
							self._regen_t = 3
							local regen_per = damage:_max_health() * 0.07
							local regen_val = damage._health + regen_per
							local new_health = math.min(regen_val, damage:_max_health())
							damage:set_health(new_health)
						else
							self._regen_t = self._regen_t - dt
						end
					end
				end
			end
		end
		return old_update(self, t, dt)
	end