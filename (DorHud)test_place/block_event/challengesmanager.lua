local module = ... or DorHUD:module("test_place")
local ChallengesManager = module:hook_class("ChallengesManager")

local old_count_up = ChallengesManager.count_up
function ChallengesManager:count_up(...)
	if module:is_this_level_ok() then
		return
	end
	return old_count_up(self, ...)
end

local old_completed_challenge = ChallengesManager._completed_challenge
function ChallengesManager:_completed_challenge(...)
	if module:is_this_level_ok() then
		return
	end
	old_completed_challenge(self, ...)
end