local PDTH_GodMode_update = PlayerDamage.update

function PlayerDamage:update(...)
	PDTH_GodMode_update(self, ...)
	if not self:god_mode() and managers.player and managers.player:player_unit() and self._unit == managers.player:player_unit() then
		self:set_god_mode(true)
	end
end