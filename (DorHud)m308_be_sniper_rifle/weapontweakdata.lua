local module = ... or DorHUD:module("m308_be_sniper_rifle")
local WeaponTweakData = module:hook_class("WeaponTweakData")

module:post_hook(WeaponTweakData, "init", function(self)
	self.m14.DAMAGE = 8
	self.m14.can_shoot_through_wall = true
end, false)