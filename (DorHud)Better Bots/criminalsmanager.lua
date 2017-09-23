	for k, v in pairs(tweak_data.character.presets.weapon.gang_member) do
		v.aim_delay = { 0, 0 }
		v.focus_delay = 0
		v.RELOAD_SPEED = 1
		v.spread = 5
	end
	for k, v in pairs(tweak_data.character.presets.weapon.gang_member.beretta92.FALLOFF) do
		v.recoil = { 0.15, 0.15 }
	end
	for k, v in pairs(tweak_data.character) do
		if type(v) == "table" and v.speech_prefix == "rb2" then
			v.SPEED_WALK = tweak_data.player.movement_state.standard.movement.speed.STANDARD_MAX
			v.SPEED_RUN = tweak_data.player.movement_state.standard.movement.speed.RUNNING_MAX
			v.dodge = tweak_data.character.presets.dodge.ninja
			v.damage.hurt_severity = tweak_data.character.tank.damage.hurt_severity
			v.damage.MIN_DAMAGE_INTERVAL = 0.15
		end
	end