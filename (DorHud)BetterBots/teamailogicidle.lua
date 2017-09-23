	local old_enter = TeamAILogicIdle.enter
	function TeamAILogicIdle.enter(data, new_logic_name, enter_params)
		old_enter(data, new_logic_name, enter_params)
		if managers.groupai:state():enemy_weapons_hot() then
			if not data.internal_data.acting then
				if not data.unit:anim_data().crouch then
					CopLogicAttack._chk_request_action_crouch(data)
				end
				if not data.unit:anim_data().reload then
					local equipped_selection = data.unit:inventory():equipped_selection()
					local damage = data.unit:character_damage()
					if equipped_selection ~= 2 and not damage:need_revive() then
						data.unit:inventory():equip_selection(2, false)
					end
					local ammo_max, ammo_cur = data.unit:inventory():equipped_unit():base():ammo_info()
					if ammo_cur < ammo_max then
						local reload_action = { type = "reload", body_part = 3 }
						data.unit:brain():action_request(reload_action)
					end
				end
			end
		end
	end
	local old_relocate = TeamAILogicIdle._calculate_should_relocate
	function TeamAILogicIdle._calculate_should_relocate(data, my_data, objective)
		old_relocate(data, my_data, objective)
		my_data.relocate_chk_t = data.t
	end
	local old_detect = TeamAILogicIdle._detect_enemies
	function TeamAILogicIdle._detect_enemies(data, my_data)
		local delay = old_detect(data, my_data)
		for e_key, e_data in pairs(managers.enemy:all_enemies()) do
			local anim_data = e_data.unit:anim_data()
			if anim_data.surrender or anim_data.hands_back or e_data.unit:brain()._current_logic_name == ("trade" or "intimidated") then
				my_data.detected_enemies[e_key] = nil
			end
		end
		return delay
	end
	local old_update = TeamAILogicIdle._update_enemy_detection
	function TeamAILogicIdle._update_enemy_detection(data)
		TeamAILogicAssault.interact_check(data)
		return old_update(data)
	end