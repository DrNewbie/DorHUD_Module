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
__test_place.__var.__temp_weapon_unit = __test_place.__var.__temp_weapon_unit or nil
__test_place.__var.__temp_weapon_idx = __test_place.__var.__temp_weapon_idx or 1

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
		--[[
		__target:character_damage().__test_place_old_die = __target:character_damage().die
		__target:character_damage().die = function(self, ...)
			spawn_people(__unit_name, __base_pos, __fix_pos)
			self:__test_place_old_die(...)
		end
		]]
	end
	return
end

local function spawn_text(__base_pos, __base_rot, __text_data)
	local __unit_name_ids = Idstring("units/dev_tools/editable_text_long/editable_text_long")
	local __text_unit = safe_spawn_unit(__unit_name_ids, __base_pos, __base_rot)
	if __text_unit.editable_gui and __text_unit:editable_gui() then
		local __text = tostring(__text_data.text)
		__text_unit:editable_gui():set_text(__text)
	end
	return
end

local function spawn_button(__base_pos, __base_rot, __text, func)
	safe_spawn_unit_without_extensions(Idstring("units/world/props/apartment/apartment_hallway_lamp/apartment_hallway_lamp"), __base_pos, __base_rot)
	local __unit_name_ids = Idstring("units/world/props/apartment/apartment_key_dummy/apartment_key_dummy")
	local __button_unit = safe_spawn_unit(__unit_name_ids, __base_pos, __base_rot)
	if __button_unit and __button_unit.interaction and __button_unit:interaction() then
		__button_unit:interaction().__test_place_old_selected = __button_unit:interaction().__test_place_old_selected or __button_unit:interaction().selected
		__button_unit:interaction().selected = function(self, ...)
			self:__test_place_old_selected(...)
			if self._tweak_data.special_equipment_block and managers.player:has_special_equipment(self._tweak_data.special_equipment_block) then
			
			else
				local icon = self._tweak_data.icon
				managers.hud:show_interact({text = __text, icon = icon})
			end
		end
		__button_unit:interaction().__test_place_old_selected = __button_unit:interaction().__test_place_old_selected or __button_unit:interaction().selected
		__button_unit:interaction().interact = function(self, ...)
			func()		
		end
	end
	return
end

local function spawn_weapon(__unit_name_ids, __base_pos, __base_rot)
	local __wep_unit = safe_spawn_unit(__unit_name_ids, __base_pos, __base_rot)
	if __wep_unit then
		local setup_data = {}
		setup_data.user_unit = managers.player:player_unit()
		setup_data.ignore_units = {
			managers.player:player_unit(),
			__wep_unit
		}
		__wep_unit:base():setup(setup_data)
	end
	return __wep_unit
end

module:pre_hook(MissionScriptElement, "on_executed", function(self)
	if module:is_this_level_ok() and module:is_this_level_ok() == "apartment" then
		local __now_time = math.round(Application:time())		
		if self._id == 100095 and not __test_place.__var.__id_100095_bool then
			__test_place.__var.__id_100095_bool = true
			__test_place.__var.__delay_block_missionscriptelement = __now_time + 10
			--[[Move to Place]]
			managers.player:set_player_state("standard")
			managers.player:warp_to(Vector3(-890, 40, 1680), Rotation())
			--[[Button to Spawn Enemies]]
			spawn_text(Vector3(-960, 300, 1785), Rotation(0, 0, 0), {text = "Enemies"})
			spawn_text(Vector3(-960, 210, 1760), Rotation(0, 90, 0), {text = "Enemies"})
			spawn_button(Vector3(-900, 250, 1780), Rotation(0, 0, 0), "Spawn Enemies", function()
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
			end)
			--[[Button to Spawn Ammo and Medic Bag]]
			spawn_text(Vector3(-765, 300, 1785), Rotation(0, 0, 0), {text = "Bags"})
			spawn_text(Vector3(-765, 210, 1760), Rotation(0, 90, 0), {text = "Bags"})
			spawn_button(Vector3(-730, 250, 1780), Rotation(0, 180, 0), "Give Ammo and Medic Bag", function()
				DoctorBagBase.spawn(Vector3(-700, 400, 1780), Rotation())
				AmmoBagBase.spawn(Vector3(-800, 400, 1780), Rotation())
			end)
			
			spawn_text(Vector3(-595, 300, 1785), Rotation(0, 0, 0), {text = "Guns"})
			spawn_text(Vector3(-595, 210, 1760), Rotation(0, 90, 0), {text = "Guns"})
			spawn_button(Vector3(-560, 250, 1780), Rotation(0, 180, 0), "Spawn Gun", function()
				if __test_place.__var.__temp_weapon_unit then
					if alive(__test_place.__var.__temp_weapon_unit) then
						World:delete_unit(__test_place.__var.__temp_weapon_unit)
					end
					if alive(__test_place.__var.__temp_weapon_unit) then
						__test_place.__var.__temp_weapon_unit:set_slot(0)
					end
					__test_place.__var.__temp_weapon_unit = nil
				end
				__test_place.__var.__temp_weapon_unit = spawn_weapon(PlayerInventory._index_to_weapon_list[__test_place.__var.__temp_weapon_idx], Vector3(-560, 250, 1830), Rotation(90, 0, 0))
				__test_place.__var.__temp_weapon_idx = __test_place.__var.__temp_weapon_idx + 1
				if __test_place.__var.__temp_weapon_idx > #(PlayerInventory._index_to_weapon_list) then
					__test_place.__var.__temp_weapon_idx = 1
				end
			end)
		end
	end
end, true)
