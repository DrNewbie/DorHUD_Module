local module = ... or D:module('pd2_anarchist_deck')
local UpgradesTweakData = module:hook_class("UpgradesTweakData")

module:post_hook(UpgradesTweakData, "_player_definitions", function(self)
	self.values.player.anarchist_lose_hp_ratio = 0.5
	self.values.player.anarchist_lose_hp_to_armor = 1.2
	self.values.player.anarchist_dmg_gain_armor = 3
	self.values.player.anarchist_dmg_gain_armor_delay = 1.5
	self.values.player.anarchist_armor_grinding_data = {
		0.1,
		2
	}
	self.values.player.anarchist_armor_break_inmune = 2
	self.values.player.anarchist_armor_break_inmune_delay = 15
end, true)