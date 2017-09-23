	local old_damage = TeamAIDamage._apply_damage
	function TeamAIDamage:_apply_damage(attack_data, result)
		local damage_percent, health_subtracted = old_damage(self, attack_data, result)
		local data = self._unit:brain()._logic_data
		if data then
			if not data.internal_data.said_hurt and self._health_ratio <= 0.2 and not self:need_revive() then
				data.internal_data.said_hurt = true
				self._unit:sound():say("g80x_plu", true)
			end
		end
		return damage_percent, health_subtracted
	end
	local old_regen = TeamAIDamage._regenerated
	function TeamAIDamage:_regenerated()
		local data = self._unit:brain()._logic_data
		if data then
			if data.internal_data.said_hurt and self._health_ratio == 1 then
				data.internal_data.said_hurt = false
			end
		end
		return old_regen(self)
	end
	function TeamAIDamage:friendly_fire_hit()
		return
	end