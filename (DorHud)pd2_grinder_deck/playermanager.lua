local module = ... or D:module('pd2_grinder_deck')
local PlayerManager = module:hook_class("PlayerManager")

function PlayerManager:_check_damage_to_hot(unit)
	local t = Application:time()
	local player_unit = self:player_unit()	
	if not alive(player_unit) or player_unit:character_damage():need_revive() or player_unit:character_damage():dead() then
		return
	end
	if not alive(unit) or not unit:base() then
		return
	end
	local data = tweak_data.upgrades.damage_to_hot_data	
	if not data then
		return
	end
	if self._next_allowed_doh_t and t < self._next_allowed_doh_t then
		return
	end
	local add_stack_sources = data.add_stack_sources or {}
	player_unit:character_damage():add_damage_to_hot()
	self._next_allowed_doh_t = t + data.stacking_cooldown
end