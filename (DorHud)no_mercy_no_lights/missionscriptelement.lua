local module = ... or D:module("no_mercy_no_lights")
local MissionScriptElement = module:hook_class("MissionScriptElement")

if MissionScriptElement and Global.level_data and Global.level_data.level_id and Global.level_data.level_id == "hospital" then
	module:post_hook(65, MissionScriptElement, "on_executed", function(self)
		if Global.level_data and Global.level_data.level_id and Global.level_data.level_id == "hospital" then
			if self:editor_name() == "lightsON" or self:editor_name() == "startup"  then
				local ele = self:get_mission_element(701171)
				if ele then
					ele:on_executed()
				end
			end
		end
	end, false)
end