local module = ... or D:module('pd2_armorer_deck')
local PlayerDamage = module:hook_class("PlayerDamage")

module:post_hook(PlayerDamage, "init", function(self)
	if not self._armorer_deck_addon_armor and tweak_data.upgrades.values.player.armorer_deck_addon_armor then
		self._armorer_deck_bool = true
		self._armorer_deck_addon_armor =  tweak_data.upgrades.values.player.armorer_deck_addon_armor * self:_max_armor()
		self._armorer_deck_inmune_during =  tweak_data.upgrades.values.player.armorer_deck_inmune_during
		self._armorer_deck_inmune_cooldown =  tweak_data.upgrades.values.player.armorer_deck_inmune_cooldown
		self._armorer_deck_inmune_run =  0
		self._armorer_deck_inmune_run_dt =  0
		self:replenish()
	end
end, true)

local old_max_armor = "F_"..Idstring("PlayerDamage:_max_armor:pd2_armorer_deck"):key()

PlayerDamage[old_max_armor] = PlayerDamage[old_max_armor] or PlayerDamage._max_armor

function PlayerDamage:_max_armor(...)
	if self._armorer_deck_bool then
		return self[old_max_armor](self, ...) + (self._armorer_deck_addon_armor or 0)
	else
		return self[old_max_armor](self, ...)
	end
end

local old_chk_dmg_too_soon = "F_"..Idstring("PlayerDamage:_chk_dmg_too_soon:pd2_armorer_deck"):key()

PlayerDamage[old_chk_dmg_too_soon] = PlayerDamage[old_chk_dmg_too_soon] or PlayerDamage._chk_dmg_too_soon

function PlayerDamage:_chk_dmg_too_soon(...)
	if self._armorer_deck_bool and self._armorer_deck_inmune_run == 1 and self._armorer_deck_inmune_run_dt then
		return true
	end
	return self[old_chk_dmg_too_soon](self, ...)
end

function PlayerDamage:_update_armorer_break_event(t, dt)
	if self._armorer_deck_bool then
		if self._armor <= 0 and self._armorer_deck_inmune_run == 0 then
			self._armorer_deck_inmune_run = 1
			self._armorer_deck_inmune_run_dt = self._armorer_deck_inmune_during
		end
		if self._armorer_deck_inmune_run == 1 and self._armorer_deck_inmune_run_dt then
			self._armorer_deck_inmune_run_dt = self._armorer_deck_inmune_run_dt - dt
			if self._armorer_deck_inmune_run_dt < 0 then
				self._armorer_deck_inmune_run = 2
				self._armorer_deck_inmune_run_dt = nil
			end
		end
		if self._armorer_deck_inmune_run == 2 then
			self._armorer_deck_inmune_run = 3
			self._armorer_deck_inmune_run_dt = self._armorer_deck_inmune_cooldown
		end
		if self._armorer_deck_inmune_run == 3 then
			self._armorer_deck_inmune_run_dt = self._armorer_deck_inmune_run_dt - dt
			if self._armorer_deck_inmune_run_dt < 0 then
				self._armorer_deck_inmune_run = 0
				self._armorer_deck_inmune_run_dt = nil
			end
		end
	end
end