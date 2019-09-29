core:import("CoreMissionScriptElement")
ElementSpawnEnemyDummy = ElementSpawnEnemyDummy or class(CoreMissionScriptElement.MissionScriptElement)

local Shield_key = Idstring("units/characters/enemies/shield/shield"):key()
local Tank_key = Idstring("units/characters/enemies/tank/tank"):key()

local SME_ElementSpawnEnemyDummy_ori_produce = ElementSpawnEnemyDummy.produce
function ElementSpawnEnemyDummy:produce(params, _, no_sme)
	local units_spawned = SME_ElementSpawnEnemyDummy_ori_produce(self, params)
	if not managers.groupai or not managers.groupai:state() or not managers.groupai:state():enemy_weapons_hot() then
		return units_spawned
	end
	if not no_sme then
		local get_unit = self._units[#self._units]
		local _unit_objective = nil
		if get_unit then
			unit_objective = get_unit:brain() and get_unit:brain():objective() or nil
		end
		for i = 1, 3 do
			local enemy_name = Idstring("units/characters/enemies/spooc/spooc")
			if self._enemy_name then
				enemy_name = self._enemy_name
			elseif params and params.name then
				enemy_name = params.name
			end
			if i >= 2 and (enemy_name:key() == Tank_key or enemy_name:key() == Shield_key) then
				break
			end
			local pos, rot = self._values.position, self._values.rotation
			local ang = math.random() * 360 * math.pi
			local rad = math.random(30, 50)
			local offset = Vector3(math.cos(ang) * rad, math.sin(ang) * rad, 0)
			local unit_done = safe_spawn_unit(enemy_name, pos + offset, rot)
			unit_done:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
			managers.groupai:state():assign_enemy_to_group_ai(unit_done)
			if unit_objective then
				unit_done:brain():set_objective(unit_objective)
			end
		end
	end
	return units_spawned
end