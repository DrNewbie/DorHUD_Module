local old_update = PlayerStandard.update
function PlayerStandard:update(t, dt)
	local damage = self._unit:character_damage()
	if damage then
		if not damage:full_health() then
			if not damage:need_revive() then
				if not self._regen_t or self._regen_t <= TimerManager:game():time() then
					self._regen_t = TimerManager:game():time() + 5
					local regen_per = damage:_max_health() * 0.1
					local regen_val = damage._health + regen_per
					local new_health = math.min(regen_val, damage:_max_health())
					damage:set_health(new_health)
				end
			end
		end
	end
	return old_update(self, t, dt)
end