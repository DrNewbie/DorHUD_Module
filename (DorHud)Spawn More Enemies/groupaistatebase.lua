function GroupAIStateBase:on_enemy_weapons_hot()
	if not self._enemy_weapons_hot then
		self._enemy_weapons_hot = true
		self:_call_listeners("enemy_weapons_hot")
		self._radio_clbk = callback(self, self, "_radio_chatter_clbk")
		managers.enemy:add_delayed_clbk("_radio_chatter_clbk", self._radio_clbk, Application:time() + 6)
		if not self._hstg_hint_clbk then
			self._first_hostage_hint = true
			self._hstg_hint_clbk = callback(self, self, "_hostage_hint_clbk")
			managers.enemy:add_delayed_clbk("_hostage_hint_clbk", self._hstg_hint_clbk, Application:time() + 9)
		end
	end
end

function GroupAIStateBase:_try_use_task_spawn_event(t, target_area, task_type, target_pos, force)
	local mvec3_dis = mvector3.distance
	target_pos = target_pos or managers.navigation._nav_segments[target_area].pos
	self._spawn_events = self._spawn_events or {}
	for _, event_data in pairs(self._spawn_events) do
		if event_data.task_type == task_type or event_data.task_type == "any" then
			local dis = mvec3_dis(target_pos, event_data.pos)
			if 1000 > dis then
				if force or math.random() < event_data.chance then
					self._anticipated_police_force = self._anticipated_police_force + event_data.amount
					self._police_force = self._police_force + event_data.amount
					self:_use_spawn_event(event_data)
					return
				else
					event_data.chance = math.min(1, event_data.chance + event_data.chance_inc)
				end
			end
		end
	end
end