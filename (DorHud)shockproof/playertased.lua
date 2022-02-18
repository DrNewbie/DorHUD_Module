local pd2_shockproof_rate = 1/3
local old_func1 = PlayerTased._update_check_actions

function PlayerTased:_update_check_actions(__t, ...)
	if self._unit and alive(self._unit) and self._unit == managers.player:player_unit() and type(self._next_shock) == "number" and __t > self._next_shock and pd2_shockproof_rate >= math.random() then
		local __myself = managers.groupai:state():criminal_record(self._unit:key())
		if __myself and __myself.being_tased then
			local __taser = managers.enemy:all_enemies()[__myself.being_tased]
			if __taser and __taser.unit and alive(__taser.unit) then
				local __taser_unit = __taser.unit
				if __taser_unit.character_damage and __taser_unit:character_damage() then
					local __expl_pos = __taser_unit:position() + Vector3(0, 0, 10)
					M79GrenadeBase._play_sound_and_effects(__expl_pos, math.UP)
					__taser_unit:character_damage():damage_explosion({
						position = __expl_pos,
						range = 10,
						damage = 10,
						col_ray = {
							position = __expl_pos,
							ray = math.UP
						}
					})
					local __player = managers.player:player_unit()
					local __ply_dmg = __player:character_damage()
					local __hurt_post = __player:position() + Vector3(0, 0, 10)
					local __hurt_dmg = __ply_dmg._health and __ply_dmg._health or 1
					__hurt_dmg = math.max(__hurt_dmg*0.25, 0.001)
					__ply_dmg._health = math.max(0, __ply_dmg._health - __hurt_dmg)
					__ply_dmg:_damage_screen()
					__ply_dmg:_check_bleed_out()
					managers.hud:set_player_health({
						current = __ply_dmg._health,
						total = __ply_dmg:_max_health()
					})
					__ply_dmg:_send_set_health()
					__ply_dmg:_set_health_effect()
				end
			end
		end
	end
	return old_func1(self, __t, ...)
end