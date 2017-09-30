local _check_action_primary_attack = PlayerStandard._check_action_primary_attack
local _StockholmSyndrome = {
	_delay = 0
}

function PlayerStandard:_check_action_primary_attack(t, input)
	local _res = _check_action_primary_attack(self, t, input)
	if self._shooting and t > _StockholmSyndrome._delay then
		math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		_StockholmSyndrome._delay = t + math.random()*10
		if math.random(1, 3) >= 2 then
			local _local_pos = self._unit:position()
			for u_key, u_data in pairs(managers.enemy:all_civilians()) do
				if mvector3.distance(u_data.unit:position(), _local_pos) <= 2500 then
					u_data.unit:brain():on_intimidated(1, self._unit)
				end			
			end
		end		
	end
	return _res
end