if not tweak_data or not tweak_data.weapon then
	return
end

tweak_data.weapon["m14"].can_shoot_through_wall = true
tweak_data.weapon["m14"].DAMAGE = 8
tweak_data.weapon["m14"].CLIP_AMMO_MAX = 6
tweak_data.weapon["m14"].NR_CLIPS_MAX = 3
tweak_data.weapon["m14"].AMMO_MAX = 18
tweak_data.weapon["m14"].fire_rate = 0.5