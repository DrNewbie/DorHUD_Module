local module = ... or D:module('pd2_grinder_deck')
local CopDamage = module:hook_class("CopDamage")

module:pre_hook(CopDamage, "_on_damage_received", function(self, attack_data)
	if attack_data and attack_data.attacker_unit and attack_data.attacker_unit == managers.player:player_unit() then
		managers.player:_check_damage_to_hot(self._unit)
	end
end, true)