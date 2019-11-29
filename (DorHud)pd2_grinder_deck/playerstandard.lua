local module = ... or D:module('pd2_grinder_deck')
local PlayerStandard = module:hook_class("PlayerStandard")

module:post_hook(PlayerStandard, "update", function(self, t, dt)
	local damage = self._unit:character_damage()
	if damage then
		damage:_upd_health_regen(t, dt)
	end
end, true)