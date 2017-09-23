function GroupAIStateStreet:_queue_police_upd_task()
	self._police_upd_task_queued = true
	managers.enemy:queue_task("GroupAIStateStreet._upd_police_activity", GroupAIStateStreet._upd_police_activity, self, self._t + 0.4)
end

local SME_GroupAIStateStreet_spawn_cops_with_objectives = GroupAIStateStreet._spawn_cops_with_objectives
function GroupAIStateStreet:_spawn_cops_with_objectives(spawn_points, ...)
	for k_sp, v_sp in pairs(spawn_points) do
		if v_sp.interval and type(v_sp.interval) == "number" and v_sp.interval > 0 then
			spawn_points[k_sp].interval = 0.35
		end
	end
	return SME_GroupAIStateStreet_spawn_cops_with_objectives(self, spawn_points, ...)
end

local SME_GroupAIStateStreet_spawn_cops_with_objective = GroupAIStateStreet._spawn_cops_with_objective
function GroupAIStateStreet:_spawn_cops_with_objective(area, spawn_points, ...)
	for k_sp, v_sp in pairs(spawn_points) do
		if v_sp.interval and type(v_sp.interval) == "number" and v_sp.interval > 0 then
			spawn_points[k_sp].interval = 0.35
		end
	end
	return SME_GroupAIStateStreet_spawn_cops_with_objective(self, area, spawn_points, ...)
end