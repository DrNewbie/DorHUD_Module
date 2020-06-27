local module = ... or D:module('pd2_muscle_deck')
local PlayerDamage = module:hook_class("PlayerDamage")

function PlayerDamage:_upd_health_regen_muscle_deck(t, dt)
	if not self:full_health() then
		if self.__muscle_regen_hp_dt then
			self.__muscle_regen_hp_dt = self.__muscle_regen_hp_dt - dt
			if self.__muscle_regen_hp_dt < 0 then
				self.__muscle_regen_hp_dt = nil
			end
		else
			self.__muscle_regen_hp_dt = tweak_data.upgrades.values.player.__pd2_muscle_regen_hp_dt
			local regen_rate = tweak_data.upgrades.values.player.__pd2_muscle_regen_hp
			self._health = self._health + regen_rate * self:_max_health()
			self:_send_set_health()
			managers.hud:set_player_health({
				current = self._health,
				total = self:_max_health()
			})		
		end
	elseif self.__muscle_regen_hp_dt then
		self.__muscle_regen_hp_dt = nil
	end	
end

local __old_max_health = PlayerDamage._max_health

function PlayerDamage:_max_health(...)
	return __old_max_health(self, ...) * tweak_data.upgrades.values.player.__pd2_muscle_more_hp
end