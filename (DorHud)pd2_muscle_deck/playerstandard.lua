local module = ... or D:module('pd2_muscle_deck')
local PlayerStandard = module:hook_class("PlayerStandard")

function PlayerStandard:__muscle_panic_suppression(t)
	if math.random() <= tweak_data.upgrades.values.player.__pd2_muscle_panic_suppression_rate then
		self.__muscle_panic_suppression_dt = t + 5 + math.random() * 20
		local _local_pos = self._unit:position()
		for u_key, u_data in pairs(managers.enemy:all_enemies()) do
			if u_data.unit and alive(u_data.unit) and u_data.unit:brain() and u_data.unit:brain().on_intimidated and mvector3.distance(u_data.unit:position(), _local_pos) <= tweak_data.upgrades.values.player.__pd2_muscle_panic_suppression_dis then
				u_data.unit:brain():set_logic("intimidated", {effect = 1})
			end
		end
	end
end

module:post_hook(PlayerStandard, "update", function(self, t, dt)
	local damage = self._unit:character_damage()
	if damage then
		damage:_upd_health_regen_muscle_deck(t, dt)
	end
end, true)

module:post_hook(PlayerStandard, "_check_action_primary_attack", function(self, t)
	local damage = self._unit:character_damage()
	if damage and t > self.__muscle_panic_suppression_dt and self._shooting then
		self:__muscle_panic_suppression(t)
	end
end, true)

module:post_hook(PlayerStandard, "init", function(self)
	self.__muscle_panic_suppression_dt = 0
end, true)