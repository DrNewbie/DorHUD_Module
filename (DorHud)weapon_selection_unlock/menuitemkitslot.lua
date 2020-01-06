core:import("CoreMenuItem")
MenuItemKitSlot = MenuItemKitSlot or class(CoreMenuItem.Item)

local module = ... or DorHUD:module('weapon_selection_unlock')
local MenuItemKitSlot = module:hook_class("MenuItemKitSlot")

module:post_hook(MenuItemKitSlot, "init", function(self)
	if self._parameters.category == "weapon" then
		self._options = {}
		for weapon_name, _ in pairs(managers.player._global.weapons) do
			table.insert(self._options, weapon_name)
		end
		table.sort(self._options, function(a,b) return a < b end)
	end
end, true)