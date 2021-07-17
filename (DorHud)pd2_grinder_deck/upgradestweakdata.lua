local module = ... or D:module('pd2_grinder_deck')
local UpgradesTweakData = module:hook_class("UpgradesTweakData")

module:post_hook(UpgradesTweakData, "_player_definitions", function(self)
	self.damage_to_hot_data = {
		tick_time = 0.3,
		stacking_cooldown = 1.5,
		total_ticks = 10,
		max_stacks = false
	}
	self.values.player.damage_to_hot = 0.4
	self.values.player.damage_to_hot_extra_ticks = 4
	self.values.player.pd2_grinder_deck_max_hp_bonus = 1.4
end, true)