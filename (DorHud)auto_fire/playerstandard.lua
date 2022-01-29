local FIRE_RATE_LIMIT = 0.066666666666
local old_func1 = PlayerStandard._check_action_primary_attack

function PlayerStandard:_check_action_primary_attack(__t, __input, ...)
	if self._equipped_unit then
		if __input.btn_primary_attack_state or __input.btn_primary_attack_release then
			local action_forbidden = self:_is_reloading() or self:_changing_weapon() or self._melee_expire_t or self._use_item_expire_t or self:_interacting()
			if not action_forbidden then
				self._queue_reload_interupt = nil
				self._ext_inventory:equip_selected_primary(false)
				local weap_base = self._equipped_unit:base()
				local fire_mode = weap_base:fire_mode()
				if fire_mode == "single" and not self._shooting and weap_base:start_shooting_allowed() then
					if self._equipped_unit:timer():time() >= weap_base._next_fire_allowed + FIRE_RATE_LIMIT then
						__input.btn_primary_attack_press = true
					end
				elseif weap_base.clip_empty and weap_base:clip_empty() then
					self:_start_action_reload_enter(__t)
				else
				
				end
			end
		end
	end
	return old_func1(self, __t, __input, ...)
end