core:import("CoreMissionScriptElement")
ElementSpawnEnemyDummy = ElementSpawnEnemyDummy or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or D:module('heavy_security')

local _heavy_security_level = DorHUD:conf('heavy_security_level') or 0

heavy_security_SSpawn = heavy_security_SSpawn or {
	id_100033 = true,
	id_100034 = true,
	id_100035 = true,
	id_100036 = true,
	id_100038 = true,
	id_100037 = true,
	id_100039 = true,
	id_100040 = true,
	id_100041 = true,
	id_100042 = true,
	id_100044 = true,
	id_100043 = true
}

module:post_hook(ElementSpawnEnemyDummy, "produce", function(self)
	if Global.level_data  and Global.level_data.level_id and Global.level_data.level_id == "diamond_heist" and heavy_security_SSpawn["id_"..self._id] then
		heavy_security_SSpawn["id_"..self._id] = false
		local get_unit = self._units[#self._units]
		local _unit_objective = nil
		if get_unit then
			_unit_objective = get_unit:brain() and get_unit:brain():objective() or nil
			for i = 1, _heavy_security_level do
				local enemy_name = get_unit:name()
				local pos, rot = self._values.position, self._values.rotation
				local _ang = math.random() * 360 * math.pi
				local _rad = math.random(30, 50)
				local offset = Vector3(math.cos(_ang) * _rad, math.sin(_ang) * _rad, 0)
				local unit_done = safe_spawn_unit(enemy_name, pos + offset, rot)
				unit_done:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))
				managers.groupai:state():assign_enemy_to_group_ai(unit_done)
				if _unit_objective then
					unit_done:brain():set_objective(_unit_objective)
				else
					unit_done:brain():set_objective({
						type = "follow",
						follow_unit = get_unit,
						called = true,
						destroy_clbk_key = false,
						scan = true,
						m_pos = get_unit:position(),
						distance = 1000
					})
				end
			end
		end
	end
end, false)