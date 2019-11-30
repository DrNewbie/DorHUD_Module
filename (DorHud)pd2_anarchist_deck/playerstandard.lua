local module = ... or D:module('pd2_anarchist_deck')
local PlayerStandard = module:hook_class("PlayerStandard")

module:post_hook(PlayerStandard, "update", function(self, t, dt)
	local damage = self._unit:character_damage()
	if damage then
		if damage._armor < damage:_max_armor() and damage._regenerate_timer then
			damage._regenerate_timer = 999			
		end
		damage:_update_armor_grinding(t, dt)
	end
end, true)