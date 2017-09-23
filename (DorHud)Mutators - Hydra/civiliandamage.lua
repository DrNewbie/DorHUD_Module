_G.MutatorsHydra = _G.MutatorsHydra or {}

local MutatorsHydra_CivilianDamage_die = CivilianDamage.die
function CivilianDamage:die(...)
	MutatorsHydra_CivilianDamage_die(self, ...)
	MutatorsHydra:split_enemy(self, true)
end