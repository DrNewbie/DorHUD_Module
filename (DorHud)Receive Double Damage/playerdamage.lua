local old_damage_explosion = PlayerDamage.damage_explosion
local old_damage_bullet = PlayerDamage.damage_bullet
local old_damage_killzone = PlayerDamage.damage_killzone
local old_damage_fall = PlayerDamage.damage_fall

local new_attack_data = function(__attack_data)
	if type(__attack_data) == "table" and type(__attack_data.damage) == "number" then
		__attack_data.damage = __attack_data.damage * 2
	end
	return __attack_data
end

function PlayerDamage:damage_bullet(attack_data, ...)
	attack_data = new_attack_data(attack_data)
	return old_damage_bullet(self, attack_data, ...)
end

function PlayerDamage:damage_explosion(attack_data, ...)
	attack_data = new_attack_data(attack_data)
	return old_damage_explosion(self, attack_data, ...)
end

function PlayerDamage:damage_killzone(attack_data, ...)
	attack_data = new_attack_data(attack_data)
	return old_damage_killzone(self, attack_data, ...)
end

function PlayerDamage:damage_fall(data, ...)
	local ans = old_damage_fall(self, data, ...)
	if ans then
		return old_damage_fall(self, data, ...)
	end
	return ans
end