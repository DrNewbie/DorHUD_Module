local module = ... or D:module('pd2_grinder_deck')
local UpgradesTweakData = module:hook_class("UpgradesTweakData")

module:post_hook(UpgradesTweakData, "_player_definitions", function(self)
	self.damage_to_hot_data = {
		tick_time = 0.3,
		works_with_armor_kit = true,
		stacking_cooldown = 1.5,
		total_ticks = 10,
		max_stacks = false,
		armors_allowed = {
			"level_1",
			"level_2"
		},
		add_stack_sources = {
			projectile = true,
			fire = true,
			bullet = true,
			melee = true,
			explosion = true,
			civilian = false,
			poison = true,
			taser_tased = true,
			swat_van = true
		}
	}
	self.values.player.damage_to_hot = 0.4
	self.values.player.damage_to_hot_extra_ticks = 4
end, true)