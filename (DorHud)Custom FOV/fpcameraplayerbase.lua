function FPCameraPlayerBase:set_fov_instant(new_fov)
	if new_fov then
		self._fov.transition = nil
		self._fov.fov = new_fov
		self._fov.dirty = true
		if Application:paused() then
			self._parent_unit:camera():set_FOV(self._fov.fov)
		end
	end
end

_CUSTOMFOV_FPSCamera_init = _CUSTOMFOV_FPSCamera_init or FPCameraPlayerBase.init

function FPCameraPlayerBase:init(...)
	_CUSTOMFOV_FPSCamera_init(self, ...)
	self._custom_fov = managers.user:get_setting("fov_zoom")
end

_CUSTOMFOV_FPSCamera_update = _CUSTOMFOV_FPSCamera_update or FPCameraPlayerBase.update

function FPCameraPlayerBase:update(...)
	_CUSTOMFOV_FPSCamera_update(self, ...)
	local v = managers.user:get_setting("fov_zoom")
	if self._custom_fov ~= v then
		self._custom_fov = v
		self:set_fov_instant(v)
	end
end