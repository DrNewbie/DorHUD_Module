local module = ... or D:module('pd2_armorer_deck')
local UpgradesTweakData = module:hook_class("UpgradesTweakData")

module:post_hook(UpgradesTweakData, "_player_definitions", function(self)
	self.values.player.armorer_deck_addon_armor = 0.35
	self.values.player.armorer_deck_inmune_during = 2
	self.values.player.armorer_deck_inmune_cooldown = 15
end, true)