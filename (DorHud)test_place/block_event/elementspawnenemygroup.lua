core:import("CoreMissionScriptElement")
ElementSpawnEnemyGroup = ElementSpawnEnemyGroup or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local ElementSpawnEnemyGroup = module:hook_class("ElementSpawnEnemyGroup")

module:pre_hook(ElementSpawnEnemyGroup, "on_executed", function(self)
	if module:is_this_level_ok() then
		self._values.enabled = false
	end
end, true)
