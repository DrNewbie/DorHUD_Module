_G.MutatorsHydra = _G.MutatorsHydra or {}

MutatorsHydra.raw_enemy_list = {
	["units/characters/enemies/dealer/dealer"] = {
		units = {"units/characters/enemies/tank/tank"}
	},
	["units/characters/enemies/tank/tank"] = {
		units = {"units/characters/enemies/spooc/spooc"}
	},
	["units/characters/enemies/spooc/spooc"] = {
		units = {"units/characters/enemies/taser/taser"}
	},
	["units/characters/enemies/taser/taser"] = {
		units = {"units/characters/enemies/shield/shield"}
	},
	["units/characters/enemies/swat_kevlar1/swat_kevlar1"] = {
		units = {
			"units/characters/enemies/fbi1/fbi1",
			"units/characters/enemies/fbi2/fbi2",
			"units/characters/enemies/fbi3/fbi3",
			"units/characters/enemies/swat/swat",
			"units/characters/enemies/swat2/swat2",
			"units/characters/enemies/swat3/swat3"
		}
	},
	["units/characters/enemies/security/patrol_guard"] = {
		units = {"units/characters/enemies/cop/cop"}
	},
	["units/characters/enemies/cop/cop"] = {
		units = {"units/characters/enemies/sniper/sniper"}
	}
}

MutatorsHydra.raw_enemy_list["units/characters/enemies/swat_kevlar2/swat_kevlar2"] = MutatorsHydra.raw_enemy_list["units/characters/enemies/swat_kevlar1/swat_kevlar1"]

for _, v in pairs({
		"units/characters/enemies/swat/swat",
		"units/characters/enemies/swat2/swat2",
		"units/characters/enemies/swat3/swat3",
		"units/characters/enemies/fbi1/fbi1",
		"units/characters/enemies/fbi2/fbi2",
		"units/characters/enemies/fbi3/fbi3"
		}) do
	MutatorsHydra.raw_enemy_list[v] = {
		units = {
			"units/characters/enemies/cop/cop",
			"units/characters/enemies/cop2/cop2",
			"units/characters/enemies/cop3/cop3",
		}
	}
end

for _, v in pairs({
		"units/characters/enemies/murky_water1/murky_water1",
		"units/characters/enemies/murky_water2/murky_water2",
		"units/characters/enemies/shield/shield"
		}) do
	MutatorsHydra.raw_enemy_list[v] = {
		units = {
			"units/characters/enemies/swat_kevlar1/swat_kevlar1",
			"units/characters/enemies/swat_kevlar2/swat_kevlar2"
		}
	}
end

for _, v in pairs({
		"units/characters/enemies/cop2/cop2",
		"units/characters/enemies/cop3/cop3",
		"units/characters/enemies/security/security_guard_01",
		"units/characters/enemies/security/security_guard_02"
		}) do
	MutatorsHydra.raw_enemy_list[v] = {
		units = {
			"units/characters/enemies/cop/cop"
		}
	}
end

MutatorsHydra._hash_enemy_list = MutatorsHydra._hash_enemy_list or {}

for k, _ in pairs(MutatorsHydra.raw_enemy_list) do
	MutatorsHydra._hash_enemy_list[Idstring(k):key()] = k
end

MutatorsHydra.split_amount = tonumber(tostring(DorHUD:conf('mutatorshydra_split_amount'))) or 2.0
if MutatorsHydra.split_amount < 0 then MutatorsHydra.split_amount = 1 end
MutatorsHydra.split_amount = math.round(MutatorsHydra.split_amount)

MutatorsHydra.max_split_times = tonumber(tostring(DorHUD:conf('mutatorshydra_max_split_times'))) or 2.0
if MutatorsHydra.max_split_times < 0 then MutatorsHydra.max_split_times = 1 end
MutatorsHydra.max_split_times = math.round(MutatorsHydra.max_split_times)

function MutatorsHydra:split_enemy(cop_damage)
	local parent_unit = cop_damage._unit
	if not parent_unit:base() then
		return
	end
	if parent_unit:base()._Hydra and parent_unit:base()._Hydra >= self.max_split_times then
		return
	end
	parent_unit:base()._Hydra = parent_unit:base()._Hydra or 0
	local spawn_selector_k = self._hash_enemy_list[parent_unit:name():key()]
	local spawn_selector = self.raw_enemy_list[spawn_selector_k]
	if spawn_selector and spawn_selector.units then
		math.randomseed(os.time())
		local spawn_selector_unit = spawn_selector.units[math.random(#spawn_selector.units)]
		for i = 1, self.split_amount do
			math.random()
			math.random()
			math.random()
			local pos, rot = parent_unit:position(), parent_unit:rotation()
			local ang = math.random() * 360 * math.pi
			local rad = math.random(30, 50)
			local offset = Vector3(math.cos(ang) * rad, math.sin(ang) * rad, 0)
			pos = pos + offset
			local unit_done = safe_spawn_unit(Idstring(spawn_selector_unit), pos, rot)
			managers.groupai:state():assign_enemy_to_group_ai(unit_done)
			unit_done:base()._Hydra = parent_unit:base()._Hydra + 1
		end
	end
end

local MutatorsHydra_CopDamage_die = CopDamage.die
function CopDamage:die(...)
	MutatorsHydra_CopDamage_die(self, ...)
	MutatorsHydra:split_enemy(self)
end