local module = ... or DorHUD:module('add_more_bonus')
local PlayerStandard = module:hook_class("PlayerStandard")
local ids_OwO_name = "__"..Idstring("PlayerStandard:init:event:add_more_bonus"):key()

module:post_hook(PlayerStandard, "update", function(self)
	if not self[ids_OwO_name] then
		self[ids_OwO_name] = true
		local menu_id = "M_"..Idstring("add_more_bonus"):key()
		if DorHUD:conf(menu_id) then
			local _type = tostring(DorHUD:conf(menu_id))
			if _type ~= "disable" or _type ~= "nil" then
				local title = managers.localization:text("debug_add_more_bonus_".._type)
				local text = managers.localization:text("debug_add_more_bonus_".._type.."_desc")
				managers.hud:present_mid_text({
					title = title,
					text = text,
					time = 10,
					icon = "equipment_hack_ipad",
					event = "stinger_objectivecomplete",
					type = "challenge"
				})
				if _type == "medic_2x" and managers.player:has_equipment("doctor_bag") then
					managers.player:add_equipment_amount("doctor_bag", 1)
				elseif _type == "ammo_2x" and managers.player:has_equipment("ammo_bag") then
					managers.player:add_equipment_amount("ammo_bag", 1)
				end		
			end
		end
	end
end, true)
