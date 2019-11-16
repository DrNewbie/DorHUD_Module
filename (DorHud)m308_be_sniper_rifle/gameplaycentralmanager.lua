local module = ... or DorHUD:module("m308_be_sniper_rifle")
local GamePlayCentralManager = module:hook_class("GamePlayCentralManager")

function GamePlayCentralManager:queue_fire_raycast(expire_t, weapon_unit, ...)
	self._queue_fire_raycast = self._queue_fire_raycast or {}
	local data = {
		expire_t = expire_t,
		weapon_unit = weapon_unit,
		data = {...}
	}
	table.insert(self._queue_fire_raycast, data)
end

function GamePlayCentralManager:_flush_queue_fire_raycast()
	local i = 1
	while i <= #self._queue_fire_raycast do
		local ray_data = self._queue_fire_raycast[i]
		if ray_data.expire_t < Application:time() then
			table.remove(self._queue_fire_raycast, i)
			local data = ray_data.data
			local user_unit = data[1]
			if alive(ray_data.weapon_unit) and alive(user_unit) then
				ray_data.weapon_unit:base():_fire_raycast(unpack(data))
			end
		else
			i = i + 1
		end
	end
end

module:post_hook(GamePlayCentralManager, "init", function(self)
	self._queue_fire_raycast = {}
end, false)

module:post_hook(GamePlayCentralManager, "end_update", function(self)
	self:_flush_queue_fire_raycast()
end, false)