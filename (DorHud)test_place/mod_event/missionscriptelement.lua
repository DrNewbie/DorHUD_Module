core:import("CoreMissionScriptElement")
core:import("CoreClass")
MissionScriptElement = MissionScriptElement or class(CoreMissionScriptElement.MissionScriptElement)

local module = ... or DorHUD:module("test_place")
local MissionScriptElement = module:hook_class("MissionScriptElement")

__test_place = __test_place or {}
__test_place.__var = __test_place.__var or {}
__test_place.__var.__delay_block_missionscriptelement = __test_place.__var.__delay_block_missionscriptelement or Application:time() + 10
__test_place.__var.__delay_block_missionscriptelement_bool = __test_place.__var.__delay_block_missionscriptelement_bool or false
__test_place.__var.__id_100095_bool = __test_place.__var.__id_100095_bool or false

local function spawn_people(__unit_name, __base_pos, __fix_pos)
	local __target = safe_spawn_unit(Idstring(__unit_name), __base_pos + __fix_pos, Rotation(180, 0, 0)) or nil
	if __target and alive(__target) and __target:brain() then
		local action_data = {
			type = "act",
			variant = "clean",
			body_part = 1,
			align_sync = true
		}
		local spawn_ai = {
			init_state = "idle",
			objective = {
				type = "act",
				action = action_data,
				interrupt_on = "contact"
			}
		}
		__target:brain():set_spawn_ai(spawn_ai)
		managers.secret_assignment:register_unit(__target)
		--__target:character_damage():set_invulnerable(true)
		--__target:brain():set_active(false)
		__target:movement():set_allow_fire(false)
		__target:movement().set_allow_fire = function()
		
		end
		__target:movement()._upd_actions = function()
		
		end
		__target:character_damage().__test_place_old_die = __target:character_damage().die
		__target:character_damage().die = function(self, ...)
			spawn_people(__unit_name, __base_pos, __fix_pos)
			self:__test_place_old_die(...)
		end
	end
	return
end

module:pre_hook(MissionScriptElement, "on_executed", function(self)
	if module:is_this_level_ok() and module:is_this_level_ok() == "apartment" then
		local __now_time = math.round(Application:time())		
		if self._id == 100095 and not __test_place.__var.__id_100095_bool then
			__test_place.__var.__id_100095_bool = true
			__test_place.__var.__delay_block_missionscriptelement = __now_time + 10
			managers.player:set_player_state("standard")
			managers.player:warp_to(Vector3(-1138, 1063, 1680), Rotation())
			for i = 1, 10 do
				DoctorBagBase.spawn(Vector3(-505, 395, 1780), Rotation())
				AmmoBagBase.spawn(Vector3(-800, 400, 1780), Rotation())
			end
			local __base_pos = Vector3(-520, 1200, 1677)
			local __spawn_list = {
				"units/characters/enemies/swat/swat",
				"units/characters/enemies/swat2/swat2",
				"units/characters/enemies/swat3/swat3",
				"units/characters/enemies/cop/cop",
				"units/characters/enemies/cop2/cop2",
				"units/characters/enemies/cop3/cop3",
				"units/characters/enemies/tank/tank",
				"units/characters/enemies/shield/shield",
				"units/characters/enemies/spooc/spooc",
				"units/characters/enemies/sniper/sniper",
				"units/characters/enemies/taser/taser",
				"units/characters/enemies/gangster1/gangster1",
				"units/characters/enemies/gangster2/gangster2",
				"units/characters/enemies/gangster3/gangster3",
				"units/characters/enemies/gangster4/gangster4",
				"units/characters/enemies/gangster5/gangster5",
				"units/characters/enemies/gangster6/gangster6",
				"units/characters/enemies/dealer/dealer"
			}
			for __id, __unit_name in pairs(__spawn_list) do
				spawn_people(__unit_name, Vector3(-520, 1200, 1677), Vector3(-75, 0, 0) * __id)
			end
		end
	end
end, true)
