local function _modify_v_delay(v)
	v = v or 0
	return 0.01 + v / 3
end
local function _modify_v_more(v, v_fix, v_rat)
	v = v or 0
	v_fix = v_fix or 0
	v_rat = v_rat or 6
	return 1 + v * v_rat + v_fix
end
local function _modify_v_little_more(v)
	v = v or 0
	return 0.5 + v * 1.75
end
local function _modify_v_per(v, v_fix)
	v = v or 0
	v_fix = v_fix or 0
	return 0.01 + v * v_fix
end
for k, v in pairs(tweak_data.group_ai.besiege.assault.delay) do
	tweak_data.group_ai.besiege.assault.delay[k] = _modify_v_delay(v)
end
for k, v in pairs(tweak_data.group_ai.besiege.assault.sustain_duration_min) do
	tweak_data.group_ai.besiege.assault.sustain_duration_min[k] = _modify_v_more(v, -10, 3)
end
for k, v in pairs(tweak_data.group_ai.besiege.assault.sustain_duration_max) do
	tweak_data.group_ai.besiege.assault.sustain_duration_max[k] = _modify_v_more(v, nil, 3)
end
for k, v in pairs(tweak_data.group_ai.street.assault.delay) do
	tweak_data.group_ai.street.assault.delay[k] = _modify_v_delay(v)
end
for k, v in pairs(tweak_data.group_ai.street.assault.sustain_duration_min) do
	tweak_data.group_ai.street.assault.sustain_duration_min[k] = _modify_v_more(v, -10, 3)
end
for k, v in pairs(tweak_data.group_ai.street.assault.sustain_duration_max) do
	tweak_data.group_ai.street.assault.sustain_duration_max[k] = _modify_v_more(v, nil, 3)
end
for k, v in pairs(tweak_data.group_ai.besiege.recon.group_size) do
	tweak_data.group_ai.besiege.recon.group_size[k] = math.round(_modify_v_more(v))
end
for k, v in pairs(tweak_data.group_ai.besiege.recon.interval) do
	tweak_data.group_ai.besiege.recon.interval[k] = _modify_v_delay(v)
end
for k, v in pairs(tweak_data.group_ai.besiege.reenforce.group_size) do
	tweak_data.group_ai.besiege.reenforce.group_size[k] = math.round(_modify_v_more(v))
end
for k, v in pairs(tweak_data.group_ai.besiege.reenforce.interval) do
	tweak_data.group_ai.besiege.reenforce.interval[k] = _modify_v_delay(v)
end
for k, v in pairs(tweak_data.group_ai.besiege.assault.force) do
	tweak_data.group_ai.besiege.assault.force[k] = _modify_v_more(v)
end
for k, v in pairs(tweak_data.group_ai.street.assault.force.aggressive) do
	tweak_data.group_ai.street.assault.force.aggressive[k] = _modify_v_more(v)
end
for k, v in pairs(tweak_data.group_ai.street.blockade.force.frontal) do
	tweak_data.group_ai.street.blockade.force.frontal[k] = _modify_v_more(v)
end
for group_name, group_data in pairs(tweak_data.group_ai.street.assault.units) do
	for k, v in pairs(group_data) do
		tweak_data.group_ai.street.assault.units[group_name][k] = _modify_v_little_more(v)
	end
end
for group_name, group_data in pairs(tweak_data.group_ai.street.capture.units) do
	for k, v in pairs(group_data) do
		tweak_data.group_ai.street.capture.units[group_name][k] = _modify_v_little_more(v)
	end
end
for group_name, group_data in pairs(tweak_data.group_ai.street.blockade.units) do
	if defend ~= 'defend' then
		for type_k, type_v in pairs(group_data) do
			for k, v in pairs(type_v) do
				tweak_data.group_ai.street.blockade.units[group_name][type_k][k] = _modify_v_little_more(v)
			end
		end
	end
end
for k, v in pairs(tweak_data.group_ai.unit_categories) do
	if v.units then
		v.max_amount = v.max_amount or 0
		if v.max_amount > 0 then
			tweak_data.group_ai.unit_categories[k].max_amount = math.round(_modify_v_more(v.max_amount))
		end
	end
end
tweak_data.group_ai.besiege.assault.build_duration = tweak_data.group_ai.besiege.assault.build_duration * 0.65
tweak_data.group_ai.street.assault.build_duration = tweak_data.group_ai.street.assault.build_duration * 0.65
tweak_data.drama.assault_fade_end = tweak_data.drama.assault_fade_end * 0.65

function GroupAIStateBesiege:_queue_police_upd_task()
	self._police_upd_task_queued = true
	managers.enemy:queue_task("GroupAIStateBesiege._upd_police_activity", GroupAIStateBesiege._upd_police_activity, self, self._t + 0.4)
end

function GroupAIStateBesiege:_map_spawn_points_to_respective_areas(id, spawn_points)
	local all_areas = self._area_data
	local nav_manager = managers.navigation
	local t = self._t
	for _, new_spawn_point in ipairs(spawn_points) do
		local pos = new_spawn_point:value("position")
		local interval = 0.35
		local amount = new_spawn_point:value("amount")
		local nav_seg = nav_manager:get_nav_seg_from_pos(pos, true)
		local accessibility = new_spawn_point:value("accessibility")
		local new_spawn_point_data = {
			id = id,
			pos = pos,
			nav_seg = nav_seg,
			spawn_point = new_spawn_point,
			amount = amount > 0 and amount,
			interval = interval,
			delay_t = -1,
			accessibility = accessibility ~= "any" and accessibility
		}
		local area_data = all_areas[nav_seg]
		local area_spawn_points = area_data.spawn_points
		if area_spawn_points then
			table.insert(area_spawn_points, new_spawn_point_data)
		else
			area_spawn_points = {new_spawn_point_data}
			area_data.spawn_points = area_spawn_points
		end
	end
end