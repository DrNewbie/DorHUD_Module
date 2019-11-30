local module = ... or D:module('pd2_anarchist_deck')
local PlayerDamage = module:hook_class("PlayerDamage")

function PlayerDamage:get_real_armor()
	return self._armor
end

function PlayerDamage:_check_update_max_armor()
	local max_armor = self:_max_armor()
	self._current_max_armor = self._current_max_armor or max_armor
	if self._current_max_armor ~= max_armor then
		local ratio = self._current_max_armor ~= 0 and max_armor / self._current_max_armor or 0
		self._current_armor_fill = self._current_armor_fill * ratio
		self._armor = Application:digest_value(math.clamp(self:get_real_armor() * ratio, 0, max_armor), true)
		self._current_max_armor = max_armor
	end
end

function PlayerDamage:set_armor(armor)
	self:_check_update_max_armor()
	armor = math.clamp(armor, 0, self:_max_armor())
	self._armor = armor
end

function PlayerDamage:change_armor(change)
	self:_check_update_max_armor()
	self:set_armor(self:get_real_armor() + change)
end

module:post_hook(PlayerDamage, "init", function(self)
	if not self._lose_max_health_to_armor then
		self._lose_max_health_ratio =  tweak_data.upgrades.values.player.anarchist_lose_hp_ratio
		self._lose_max_health_to_armor = self:_max_health()
		self._lose_max_health_to_armor = self._lose_max_health_to_armor * self._lose_max_health_ratio
		self._lose_max_health_to_armor = self._lose_max_health_to_armor * tweak_data.upgrades.values.player.anarchist_lose_hp_to_armor
		self:replenish()
		local armor_grinding_data = tweak_data.upgrades.values.player.anarchist_armor_grinding_data or {}
		if armor_grinding_data and armor_grinding_data[1] and armor_grinding_data[2] then
			self._armor_grinding = {
				armor_value = armor_grinding_data[1],
				target_tick = armor_grinding_data[2],
				elapsed = 0
			}
		end
		self._anarchist_dmg_gain_armor_delay = tweak_data.upgrades.values.player.anarchist_dmg_gain_armor_delay
		self._anarchist_dmg_gain_armor = tweak_data.upgrades.values.player.anarchist_dmg_gain_armor
		self._anarchist_armor_break_inmune = tweak_data.upgrades.values.player.anarchist_armor_break_inmune
		self._anarchist_armor_break_inmune_delay = tweak_data.upgrades.values.player.anarchist_armor_break_inmune_delay
	end
end, true)

local old_max_armor = PlayerDamage._max_armor

function PlayerDamage:_max_armor(...)
	return old_max_armor(self, ...) + (self._lose_max_health_to_armor or 0)
end

local old_max_health = PlayerDamage._max_health

function PlayerDamage:_max_health(...)
	return old_max_health(self, ...) * (self._lose_max_health_ratio or 1)
end

function PlayerDamage:anarchist_dmg_gain_armor_event()
	self._ask_anarchist_dmg_gain_armor = true
end

local old_chk_dmg_too_soon = PlayerDamage._chk_dmg_too_soon

function PlayerDamage:_chk_dmg_too_soon(...)
	if self._run_anarchist_armor_break_inmune then
		return true
	end
	return old_chk_dmg_too_soon(self, ...)
end

function PlayerDamage:_update_armor_grinding(t, dt)
	if self._armor_grinding then
		self._armor_grinding.elapsed = self._armor_grinding.elapsed + dt
		if self._armor_grinding.target_tick <= self._armor_grinding.elapsed then
			self._armor_grinding.elapsed = 0
			self:change_armor(self._armor_grinding.armor_value)
		end
	end
	if self._ask_anarchist_dmg_gain_armor then
		self._ask_anarchist_dmg_gain_armor = false
		if not self._ask_anarchist_dmg_gain_armor_delay then
			self._ask_anarchist_dmg_gain_armor_delay = t + (self._anarchist_dmg_gain_armor_delay or 0)
			self:change_armor(self._anarchist_dmg_gain_armor)
		end
	end
	if self._ask_anarchist_dmg_gain_armor_delay and self._ask_anarchist_dmg_gain_armor_delay < t then
		self._ask_anarchist_dmg_gain_armor_delay = nil	
	end
	if self._armor <= 0 and not self._armor_break_bool then
		self._armor_break_bool = true
		if not self._ask_anarchist_armor_break_inmune then
			self._ask_anarchist_armor_break_inmune = t + self._anarchist_armor_break_inmune_delay
			self._run_anarchist_armor_break_inmune = t + self._anarchist_armor_break_inmune		
		end
	end
	if self._armor > 0 and self._armor_break_bool then
		self._armor_break_bool = nil
	end
	if self._ask_anarchist_armor_break_inmune and self._ask_anarchist_armor_break_inmune < t then
		self._ask_anarchist_armor_break_inmune = nil	
	end
	if self._run_anarchist_armor_break_inmune and self._run_anarchist_armor_break_inmune < t then
		self._run_anarchist_armor_break_inmune = nil	
	end
end