	local old_tasestart = GroupAIStateBase.on_tase_start
	function GroupAIStateBase:on_tase_start(cop_key, criminal_key)
		local bot_record = self._ai_criminals[criminal_key]
		if bot_record then
			local taser_unit = self._police[cop_key].unit
			if not managers.game_play_central._enemy_contour_units[taser_unit:key()] then
				bot_record.unit:sound():say("f32x_any", true)
				managers.game_play_central:add_enemy_contour(taser_unit)
			end
		end
		return old_tasestart(self, cop_key, criminal_key)
	end