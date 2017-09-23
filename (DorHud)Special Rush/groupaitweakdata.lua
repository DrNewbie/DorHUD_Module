local module = ... or DorHUD:module('SpecialRush')

local PDTH_SpecialRush_Tweak = GroupAITweakData.init

function GroupAITweakData:init(...)
	PDTH_SpecialRush_Tweak(self, ...)
    for k, v in pairs(self.unit_categories or {}) do
		if v.units then
			local _units = self.unit_categories[k].units
			local _runed = false
			self.unit_categories[k].units = {}
			self.unit_categories[k].access = {"walk", "acrobatic"}
			if DorHUD:conf('specialrush_add_bulldozer') then
				_runed = true
				table.insert(self.unit_categories[k].units, Idstring("units/characters/enemies/tank/tank"))
			end
			if DorHUD:conf('specialrush_add_cloaker') then
				_runed = true
				table.insert(self.unit_categories[k].units, Idstring("units/characters/enemies/spooc/spooc"))
			end
			if DorHUD:conf('specialrush_add_tazer') then
				_runed = true
				table.insert(self.unit_categories[k].units, Idstring("units/characters/enemies/taser/taser"))
			end
			if DorHUD:conf('specialrush_add_shield') then
				_runed = true
				table.insert(self.unit_categories[k].units, Idstring("units/characters/enemies/shield/shield"))
			end
			if DorHUD:conf('specialrush_add_sniper') then
				_runed = true
				table.insert(self.unit_categories[k].units, Idstring("units/characters/enemies/sniper/sniper"))
			end
			if not _runed then
				self.unit_categories[k].units = _units
			end
		end
	end
end