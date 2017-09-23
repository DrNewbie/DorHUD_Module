	local init_original = RaycastWeaponBase.init
	local setup_original = RaycastWeaponBase.setup
	function RaycastWeaponBase:init(unit)
		init_original(self, unit)
		self._bullet_slotmask = self._bullet_slotmask - World:make_slot_mask(16)
	end
	function RaycastWeaponBase:setup(setup_data)
		setup_original(self, setup_data)
		self._bullet_slotmask = self._bullet_slotmask - World:make_slot_mask(16)
	end