local module = ... or DMod:module('pd2_ace_inspire')

local PlayerMovement = module:hook_class("PlayerMovement")

module:post_hook(PlayerMovement, "post_init", function(self)
	self._rally_skill_data = {
		range_sq = 810000,
		long_dis_revive_delay_t = 0,
		long_dis_revive = true,
		revive_chance = 1,
		long_dis_revive_cooldown_t = 20
	}
end, false)

function PlayerMovement:rally_skill_data()
	return self._rally_skill_data
end