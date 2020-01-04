local Wrld = getmetatable(World:effect_manager())

if Wrld.spawn then
	Wrld._orgi_spawn = Wrld._orgi_spawn or Wrld.spawn
	local function effect_spawn(self, ...)
		return nil
	end
	Wrld.spawn = effect_spawn
end