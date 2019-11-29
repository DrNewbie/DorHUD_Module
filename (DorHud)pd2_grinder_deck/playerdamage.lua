local module = ... or D:module('pd2_grinder_deck')
local PlayerDamage = module:hook_class("PlayerDamage")

function PlayerDamage:get_real_health()
	return self._health
end

function PlayerDamage:_check_update_max_health()
	local max_health = self:_max_health()
	self._current_max_health = self._current_max_health or self:_max_health()
	if self._current_max_health ~= max_health then
		local ratio = max_health / self._current_max_health
		local health = math.clamp(self:get_real_health() * ratio, 0, max_health)
		self._health = health
		self._current_max_health = max_health
	end
end

function PlayerDamage:change_health(change_of_health)
	self:_check_update_max_health()
	return self:set_health(self:get_real_health() + change_of_health)
end

function PlayerDamage:restore_health(health_restored, is_static)
	if is_static then
		return self:change_health(health_restored * self._healing_reduction)
	else
		local max_health = self:_max_health()
		return self:change_health(max_health * health_restored * self._healing_reduction)
	end
end

function PlayerDamage:_upd_health_regen(t, dt)
	if #self._damage_to_hot_stack > 0 then
		repeat
			local next_doh = self._damage_to_hot_stack[1]
			local done = not next_doh or TimerManager:game():time() < next_doh.next_tick
			if not done then
				local regen_rate = (tweak_data.upgrades.values.player.damage_to_hot or 0)
				self:restore_health(regen_rate, true)
				next_doh.ticks_left = next_doh.ticks_left - 1
				if next_doh.ticks_left == 0 then
					table.remove(self._damage_to_hot_stack, 1)
				else
					next_doh.next_tick = next_doh.next_tick + (self._doh_data.tick_time or 1)
				end
				table.sort(self._damage_to_hot_stack, function (x, y)
					return x.next_tick < y.next_tick
				end)
			end
		until done
	end
end

function PlayerDamage:got_max_doh_stacks()
	return self._doh_data.max_stacks and #self._damage_to_hot_stack >= (tonumber(self._doh_data.max_stacks) or 1)
end

function PlayerDamage:add_damage_to_hot()
	if self:got_max_doh_stacks() then
		return
	end
	if self:need_revive() or self:dead() then
		return
	end
	table.insert(self._damage_to_hot_stack, {
		next_tick = TimerManager:game():time() + (self._doh_data.tick_time or 1),
		ticks_left = (self._doh_data.total_ticks or 1) + (tweak_data.upgrades.values.player.damage_to_hot_extra_ticks or 0)
	})
	table.sort(self._damage_to_hot_stack, function (x, y)
		return x.next_tick < y.next_tick
	end)
end

module:post_hook(PlayerDamage, "init", function(self)
	self._doh_data = tweak_data.upgrades.damage_to_hot_data or {}
	self._damage_to_hot_stack = {}
	self._healing_reduction = 1
end, true)

module:post_hook(PlayerDamage, "_check_bleed_out", function(self)
	if self:bleed_out() then
		self._damage_to_hot_stack = {}
	end
end, true)

local old_max_health = PlayerDamage._max_health

function PlayerDamage:_max_health(...)
	return old_max_health(self, ...) * 1.4
end