core:import("CoreMissionScriptElement")
ElementObjective = ElementObjective or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local ElementObjective = module:hook_class("ElementObjective")

module:pre_hook(ElementObjective, "on_executed", function(self)
	if module:is_this_level_ok() then
		self._values.enabled = false
	end
end, true)
