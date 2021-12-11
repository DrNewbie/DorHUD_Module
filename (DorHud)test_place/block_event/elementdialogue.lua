core:import("CoreMissionScriptElement")
ElementDialogue = ElementDialogue or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local ElementDialogue = module:hook_class("ElementDialogue")

module:pre_hook(ElementDialogue, "on_executed", function(self)
	if module:is_this_level_ok() then
		self._values.enabled = false
	end
end, true)
