core:import("CoreMissionScriptElement")
ElementSpawnEnemyDummy = ElementSpawnEnemyDummy or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local ElementSpawnEnemyDummy = module:hook_class("ElementSpawnEnemyDummy")

module:pre_hook(ElementSpawnEnemyDummy, "on_executed", function(self)
	if module:is_this_level_ok() then
		self._values.enabled = false
	end
end, true)
