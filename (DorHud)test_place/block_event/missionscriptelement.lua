core:import("CoreMissionScriptElement")
core:import("CoreClass")
MissionScriptElement = MissionScriptElement or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local MissionScriptElement = module:hook_class("MissionScriptElement")

__test_place = __test_place or {}
__test_place.__var = __test_place.__var or {}
__test_place.__var.__delay_block_missionscriptelement = __test_place.__var.__delay_block_missionscriptelement or Application:time() + 10
__test_place.__var.__delay_block_missionscriptelement_bool = __test_place.__var.__delay_block_missionscriptelement_bool or false

module:pre_hook(MissionScriptElement, "on_executed", function(self)
	if module:is_this_level_ok() then
		local __now_time = math.round(Application:time())
		if __now_time >= __test_place.__var.__delay_block_missionscriptelement then
			self._values.enabled = false
			if not __test_place.__var.__delay_block_missionscriptelement_bool then
				__test_place.__var.__delay_block_missionscriptelement_bool = true
				local RemoveThisUnits = {
					["673ea142d68175df"] = true,
					["86efb80bf784046f"] = true,
					["b37a4188fde4c161"] = true,
					["7ae8fcbfe6a00f7b"] = true,
					["c5c4442c5e147cb0"] = true,
					["8f3cb89b79b42ec4"] = true,
					["e8fe662bb4d262d3"] = true,
					["9d8b22836aa015ed"] = true,
					["63be2c801283f573"] = true,
					["78f4407343b48f6d"] = true,
					["29d0139549a54de7"] = true,
					["e379cc9592197cd8"] = true,
					["7a4c85917d8d8323"] = true,
					["9eda9e73ac0ef710"] = true,
					["276de19dc5541f30"] = true,
					["6cdb4f6f58ec4fa8"] = true
				}
				for _, __unit in pairs(World:find_units_quick("all", 1)) do
					if RemoveThisUnits[__unit:name():key()] then
						__unit:set_slot(0)
					end
				end  
			end
		end
	end
end, true)
