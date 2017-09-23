	local old_enter = TeamAILogicTravel.enter
	function TeamAILogicTravel.enter(data, new_logic_name, enter_params)
		old_enter(data, new_logic_name, enter_params)
		if not data.internal_data.acting then
			CopLogicAttack._chk_request_action_stand(data)
		end
	end
	local old_occ = TeamAILogicTravel._determine_destination_occupation
	function TeamAILogicTravel._determine_destination_occupation(data, objective)
		local occupation = old_occ(data, objective)
		if objective.follow_unit then
			if objective.type ~= "revive" then
				local cover = TeamAILogicAssault.get_cover_data(data)
				if cover then
					local cover_entry = {cover}
					occupation = { type = "defend", cover = cover_entry }
				else
					local follow_pos = mvector3.copy(objective.follow_unit:movement():nav_tracker():field_position())
					local to_pos = CopLogicTravel._get_pos_on_wall(follow_pos, 400)
					if to_pos then
						occupation = { type = "defend", pos = to_pos }
					end
				end
			end
		end
		return occupation
	end
	local old_upd = TeamAILogicTravel._upd_pathing
	function TeamAILogicTravel._upd_pathing(data, my_data)
		if data.objective then
			if data.objective.follow_unit then
				if data.objective.type ~= "revive" then
					if data.objective.in_place then
						if not my_data.moving_to_cover then
							if not data.unit:anim_data().reload then
								local head_pos = data.unit:movement():m_head_pos()
								local u_head_pos = data.objective.follow_unit:movement():m_head_pos()
								local slotmask = managers.slot:get_mask("AI_visibility")
								local ray = World:raycast("ray", head_pos, u_head_pos, "slot_mask", slotmask, "ray_type", "ai_vision")
								if mvector3.distance(head_pos, u_head_pos) <= 800 and not ray then
									local focus_enemy = my_data.focus_enemy
									if focus_enemy and focus_enemy.verified then
										CopLogicBase._exit(data.unit, "assault")
									else
										CopLogicBase._exit(data.unit, "idle", {scan = true})
									end
								end
							end
						end
					end
				end
			end
		end
		return old_upd(data, my_data)
	end
	local old_update = TeamAILogicTravel._update_enemy_detection
	function TeamAILogicTravel._update_enemy_detection(data)
		TeamAILogicAssault.interact_check(data)
		return old_update(data)
	end