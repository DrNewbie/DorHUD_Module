local module = ... or D:module('pd2_muscle_deck')
local UpgradesTweakData = module:hook_class("UpgradesTweakData")

module:post_hook(UpgradesTweakData, "_player_definitions", function(self)
	self.values.player.__pd2_muscle_more_hp = 1.8
	self.values.player.__pd2_muscle_regen_hp = 0.03
	self.values.player.__pd2_muscle_regen_hp_dt = 5
	self.values.player.__pd2_muscle_panic_suppression_rate = 0.35
	self.values.player.__pd2_muscle_panic_suppression_dis = 1500
end, true)