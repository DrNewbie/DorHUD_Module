core:import("CoreMissionScriptElement")
core:import("CoreClass")
MissionScriptElement = MissionScriptElement or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("isolation_helper")
local MissionScriptElement = module:hook_class("MissionScriptElement")

local function IsolationRoomHelper_WPAttachedFunc(id, name)
	if module:is_this_level_ok() then
		if (id == 700023 and name == "saw1Correct") or (id == 700022 and name == "saw2Correct") or (id == 700021 and name == "saw3Correct") then
			module:WPOFF()
		elseif id == 700012 and name == "room1" then
			module.SAW_Position = Vector3(-1350, 2071, 150)
			module:WPON()
		elseif id == 700013 and name == "room2" then
			module.SAW_Position = Vector3(-1014, 2043, 150)
			module:WPON()
		elseif id == 102312 and name == "700014" then
			module.SAW_Position = Vector3(-1013, 2571, 150)
			module:WPON()
		end
	end
	return
end

module:post_hook(MissionScriptElement, "on_executed", function(self)
	if module:is_this_level_ok() then
		IsolationRoomHelper_WPAttachedFunc(self._id, self._editor_name)
	end
end)

module:post_hook(MissionScriptElement, "client_on_executed", function(self)
	if module:is_this_level_ok() then
		IsolationRoomHelper_WPAttachedFunc(self._id, self._editor_name)
	end
end)