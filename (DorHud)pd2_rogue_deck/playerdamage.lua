local module = ... or D:module('pd2_rogue_deck')
local PlayerDamage = module:hook_class("PlayerDamage")

module:post_hook(PlayerDamage, "init", function(self)
	self._rogue_dodge_chance = tweak_data.upgrades.values.player.rogue_dodge_chance
end, true)

local old_damage_bullet = PlayerDamage.damage_bullet

function PlayerDamage:damage_bullet(...)
	if math.random() <= self._rogue_dodge_chance then
		return	
	end
	return old_damage_bullet(self, ...)
end