local module = ... or D:module('pd2_anarchist_deck')
local CopDamage = module:hook_class("CopDamage")

module:pre_hook(CopDamage, "_on_damage_received", function(self, attack_data)
	if attack_data and attack_data.attacker_unit and attack_data.attacker_unit == managers.player:player_unit() then
		local damage = attack_data.attacker_unit:character_damage()
		if damage then
			damage:anarchist_dmg_gain_armor_event()
		end
	end
end, true)