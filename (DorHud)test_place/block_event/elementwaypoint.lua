core:import("CoreMissionScriptElement")
ElementWaypoint = ElementWaypoint or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local ElementWaypoint = module:hook_class("ElementWaypoint")

module:pre_hook(ElementWaypoint, "on_executed", function(self)
	if module:is_this_level_ok() then
		self._values.enabled = false
	end
end, true)
