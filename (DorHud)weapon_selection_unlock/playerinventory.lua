local module = ... or DorHUD:module('weapon_selection_unlock')

function PlayerInventory:alt_add_unit_by_name(new_unit_name, equip, instant, selection_index)
	local new_unit = World:spawn_unit(new_unit_name, Vector3(), Rotation())
	local setup_data = {}
	setup_data.user_unit = self._unit
	setup_data.ignore_units = {
		self._unit,
		new_unit
	}
	setup_data.expend_ammo = true
	setup_data.autoaim = true
	setup_data.alert_AI = true
	new_unit:base():setup(setup_data)
	self:alt_add_unit(new_unit, equip, instant, selection_index)
end

function PlayerInventory:alt_add_unit(new_unit, is_equip, equip_is_instant, selection_index)
	local new_selection = {}
	local use_data = new_unit:base():get_use_data(self._use_data_alias)
	new_selection.use_data = use_data
	new_selection.unit = new_unit
	new_unit:base():add_destroy_listener(self._listener_id, callback(self, self, "clbk_weapon_unit_destroyed"))
	if self._available_selections[selection_index] then
		local old_weapon_unit = self._available_selections[selection_index].unit
		is_equip = is_equip or old_weapon_unit == self:equipped_unit()
		old_weapon_unit:base():remove_destroy_listener(self._listener_id)
		old_weapon_unit:base():set_slot(old_weapon_unit, 0)
		if self._equipped_selection == selection_index then
			self._equipped_selection = nil
		end
	end
	self._available_selections[selection_index] = new_selection
	self._latest_addition = selection_index
	self._selected_primary = self._selected_primary or selection_index
	self:_call_listeners("add")
	if is_equip then
		self:equip_latest_addition(equip_is_instant)
	else
		self:_place_selection(selection_index, is_equip)
	end
end