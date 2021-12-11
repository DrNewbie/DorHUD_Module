core:import("CoreMissionScriptElement")
ElementSpawnCivilianGroup = ElementSpawnCivilianGroup or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local ElementSpawnCivilianGroup = module:hook_class("ElementSpawnCivilianGroup")

module:pre_hook(ElementSpawnCivilianGroup, "on_executed", function(self)
	if module:is_this_level_ok() then
		self._values.enabled = false
	end
end, true)
