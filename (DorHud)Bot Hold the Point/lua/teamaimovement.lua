function TeamAIMovement:set_should_stay(should_stay)
	if self._should_stay ~= should_stay then
		self._should_stay = should_stay
	end
end

local old_chk_action_forbidden = TeamAIMovement.chk_action_forbidden

function TeamAIMovement:chk_action_forbidden(action_type, ...)
	if action_type == "walk" and self._should_stay then
		if Network:is_server() and self._unit:brain():objective() and (self._unit:brain():objective().type == "revive" or self._unit:brain():objective().forced) then
			return false
		end
		return true
	end
	return old_chk_action_forbidden(self, action_type, ...)
end

local old_save = TeamAIMovement.save

function TeamAIMovement:save(save_data, ...)
	old_save(self, save_data, ...)
	if save_data and save_data.movement then
		save_data.movement.should_stay = self._should_stay
	end
end

local old_load = TeamAIMovement.load

function TeamAIMovement:load(load_data, ...)
	old_load(self, load_data, ...)
	if load_data and load_data.movement then
		self:set_should_stay(load_data.movement.should_stay)
	end
end