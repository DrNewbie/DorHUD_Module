local module = ... or D:module('pd2_armorer_deck')
local PlayerStandard = module:hook_class("PlayerStandard")

module:post_hook(PlayerStandard, "update", function(self, t, dt)
	local damage = self._unit:character_damage()
	if damage then
		damage:_update_armorer_break_event(t, dt)
	end
end, true)