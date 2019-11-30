local module = ... or D:module('pd2_rogue_deck')
local UpgradesTweakData = module:hook_class("UpgradesTweakData")

module:post_hook(UpgradesTweakData, "_player_definitions", function(self)
	self.values.player.rogue_dodge_chance = 0.15 + 0.05 + 0.15 + 0.15 + 0.1
	self.values.player.rogue_fast_hand = 1.8
end, true)