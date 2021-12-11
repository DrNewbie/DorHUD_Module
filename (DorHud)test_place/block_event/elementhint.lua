core:import("CoreMissionScriptElement")
ElementHint = ElementHint or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local ElementHint = module:hook_class("ElementHint")

module:pre_hook(ElementHint, "on_executed", function(self)
	if module:is_this_level_ok() then
		self._values.enabled = false
	end
end, true)
