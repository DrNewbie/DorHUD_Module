local module = ... or D:module('pd2_rogue_deck')
local UpgradesTweakData = module:hook_class("PlayerStandard")

module:post_hook(PlayerStandard, "_start_action_unequip_weapon", function(self, t, dt)
	if self._unequip_weapon_expire_t then
		local speed_multiplier = tweak_data.upgrades.values.player.rogue_fast_hand
		self._equipped_unit:base():tweak_data_anim_play("unequip", speed_multiplier)
		self._unequip_weapon_expire_t = t + (tweak_data.timers and tweak_data.timers.unequip or 0.5) / speed_multiplier
		self._unit:camera():play_redirect(self.IDS_UNEQUIP, speed_multiplier)
	end
end, true)