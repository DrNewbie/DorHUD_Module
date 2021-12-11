local module = ... or DorHUD:module("test_place")
local AchievmentManager = module:hook_class("AchievmentManager")

local old_award = AchievmentManager.award
function AchievmentManager:award(...)
	if module:is_this_level_ok() then
		return
	end
	return old_award(self, ...)
end