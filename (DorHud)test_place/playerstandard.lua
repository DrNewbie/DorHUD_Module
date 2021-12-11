local module = ... or DorHUD:module("test_place")
local MenuNodeGui = module:hook_class("PlayerStandard")

module:post_hook(PlayerStandard, "update", function(self)
	if self:shooting() then
		log("pos:"..tostring(self._unit:position()))
		log("rot:"..tostring(self._unit:rotation()))
	end
end, true)