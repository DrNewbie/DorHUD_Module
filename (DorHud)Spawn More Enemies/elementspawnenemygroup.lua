core:import("CoreMissionScriptElement")
ElementSpawnEnemyGroup = ElementSpawnEnemyGroup or class(CoreMissionScriptElement.MissionScriptElement)

function ElementSpawnEnemyGroup:on_executed(instigator)
	if not self._values.enabled then
		return
	end
	self:_check_spawn_points()
	if #self._spawn_points > 0 then
		for i = 1, self._group_data.amount do
			local element = self._spawn_points[self:_get_spawn_point(i)]
			element:produce(nil, nil, true)
			if managers.groupai and managers.groupai:state() and managers.groupai:state():enemy_weapons_hot() then
				element:produce(nil, nil, true)
				element:produce(nil, nil, true)
			end
		end

	end
	ElementSpawnEnemyGroup.super.on_executed(self, instigator)
end