local module = ... or DorHUD:module('weapon_selection_unlock')
local PlayerManager = module:hook_class("PlayerManager")

module:post_hook(PlayerManager, "_internal_load", function(self)
	local player = self:player_unit()
	if player then
		for i, name in pairs(self._global.kit.weapon_slots) do
			if i <= PlayerManager.WEAPON_SLOTS then
				local ok_name = self._global.weapons[name] and name or self._global.weapons[self._global.default_kit.weapon_slots[i]] and self._global.default_kit.weapon_slots[i]
				if ok_name then
					local upgrade = tweak_data.upgrades.definitions[ok_name]
					if upgrade then
						player:inventory():alt_add_unit_by_name(upgrade.unit_name, i == 1, false, i)
					end
				end
			end
		end
	end
end, true)