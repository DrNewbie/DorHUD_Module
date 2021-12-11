core:import("CoreMissionScriptElement")
ElementSpawnCivilian = ElementSpawnCivilian or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local ElementSpawnCivilian = module:hook_class("ElementSpawnCivilian")

module:pre_hook(ElementSpawnCivilian, "on_executed", function(self)
	if module:is_this_level_ok() then
		self._values.enabled = false
	end
end, true)
