core:import("CoreEvent")
core:import("CoreApp")
core:import("CoreFreeFlightAction")
core:import("CoreFreeFlightModifier")

FreeFlightCamera = FreeFlightCamera or {}
local FF_ON, FF_OFF, FF_ON_NOCON = 0, 1, 2
local MOVEMENT_SPEED_BASE = 1000
local FAR_RANGE_MAX = 250000
local TURN_SPEED_BASE = 1
local PITCH_LIMIT_MIN = -80
local PITCH_LIMIT_MAX = 80
local TEXT_FADE_TIME = 0.3
local TEXT_ON_SCREEN_TIME = 2
local FREEFLIGHT_HEADER_TEXT = "FREEFLIGHT, PRESS 'F' OR 'C'"
local DESELECTED = Color.white
local SELECTED = Color(0, 0.4, 1)
function FreeFlightCamera:init()
	if managers.controller:get_controller_by_name("freeflight") then
		return
	end
	self._state = FF_OFF
	self._camera_object = World:create_camera()
	self._camera_object:set_far_range(FAR_RANGE_MAX)
	self._fov = 75
	self._camera_object:set_fov(self._fov)
	self._vp = managers.viewport:new_vp(0, 0, 1, 1, "FreeFlightCamera", 10)
	self._vp:set_camera(self._camera_object)
	self._camera_pos = self._camera_object:position()
	self._camera_rot = self._camera_object:rotation()	   
	self._con = managers.controller:create_controller("freeflight", nil, true, 10)
	self._turn_speed = 5 
	self._camera_speed = 2   
	self._trigger_ids = {}
	Input:keyboard():add_trigger(Idstring("f9"), callback(self, self, "show_key_pressed"))
	Input:keyboard():add_trigger(Idstring("f8"), callback(self, self, "toggle_gui"))
	self:_setup_modifiers()
	self:_setup_actions()
	self:setup_gui()	
	self._con:add_trigger("freeflight_action_toggle", callback(self, self, "action_toggle"))
	self._con:add_trigger("freeflight_action_execute", callback(self, self, "action_execute"))
	self._con:add_trigger("freeflight_quick_action_execute", callback(self, self, "quick_action_execute"))
	self._con:add_trigger("freeflight_modifier_toggle", callback(self, self, "next_modifier_toggle"))
	self._con:add_trigger("freeflight_modifier_up", callback(self, self, "curr_modifier_up"))
	self._con:add_trigger("freeflight_modifier_down", callback(self, self, "curr_modifier_down"))
end

function FreeFlightCamera:setup_gui()
	local gui_scene = Overlay:gui()
	local res = RenderSettings.resolution
	self._workspace = gui_scene:create_screen_workspace()
	self._workspace:set_timer(TimerManager:main())
	self._panel = self._workspace:panel()
	local SCREEN_RIGHT_OFFSET = 200
	local TEXT_HEIGHT_OFFSET = 28
	local config = {
		x = 2, 
		y = 2,
		font = tweak_data.menu.default_font,
		color = DESELECTED,
	}
	local function anim_fade_out_func(o)
		CoreEvent.over(TEXT_FADE_TIME, function(t)
			o:set_alpha(1 - t)
		end)
	end
	local function anim_fade_in_func(o)
		CoreEvent.over(TEXT_FADE_TIME, function(t)
			o:set_alpha(t)
		end)
	end
	local text_script = {fade_out = anim_fade_out_func, fade_in = anim_fade_in_func}
	self._action_gui = {}
	self._action_vis_time = nil
	for i, a in ipairs(self._actions) do
		local panel = self._panel:panel({
			x = 45,
			y = 25,
			layer = 1000000,
		})
		local text = panel:text(config)  
		panel:rect({
			color = Color.black,
			alpha = 0.4
		})
		panel:set_script(text_script)
		text:set_text(a:name())		  
		local _,_,w,h = text:text_rect()
		panel:set_size(w + 2, h + 2)			  
		panel:set_y(panel:y() + i * TEXT_HEIGHT_OFFSET)
		if i == self._action_index then
			text:set_color(SELECTED)
		end
		table.insert(self._action_gui, panel)
	end
	self._modifier_gui = {}
	self._modifier_vis_time = nil
	for i, m in ipairs(self._modifiers) do
		local panel = self._panel:panel({
			x = 45, 
			y = 25,
			layer = 1000000,
		})   
		local text = panel:text(config)

		panel:rect({
			color = Color.black,
			alpha = 0.4
		})
		panel:set_script(text_script)
		text:set_text(m:name_value())
		panel:set_y(text:y() + i * TEXT_HEIGHT_OFFSET)
		local _,_,w,h = text:text_rect()
		panel:set_size(w + 2, h + 2)		
		panel:set_world_right(self._panel:world_right() - 45)		
		if i == self._modifier_index then
			text:set_color(SELECTED)
		end
		table.insert(self._modifier_gui, panel)
	end
	self._workspace:hide()
end
function FreeFlightCamera:_setup_modifiers()
local FFM = CoreFreeFlightModifier.FreeFlightModifier
	local ms = FFM:new("Move Speed", {0.02,0.05,0.1,0.2,0.3,0.4,0.5,1,2,3,4,5,8,11,14,18,25,30,40,50,60,70,80,100,120,140,160,180,200}, 9)
	local ts = FFM:new("Turn Speed", {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, 5)
	local gt = FFM:new("Game Speed", {0.1,0.2,0.3, 0.4,0.5, 0.6, 0.7,0.8,0.9,1,1.1,1.2,1.3,1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10}, 10, callback(self, self, "set_game_speed"))
	local fov_numbers = {}
	for i=1, 110 do
		table.insert(fov_numbers, i)
	end
	local fov = FFM:new("FOV", fov_numbers, table.get_key(fov_numbers, 75), callback(self, self, "set_fov"))
	self._modifiers = {ms,ts,gt,fov}
	self._modifier_index = 1
	self._fov = fov
	self._move_speed = ms
	self._turn_speed = ts
end
function FreeFlightCamera:_setup_actions()
	local FFA = CoreFreeFlightAction.FreeFlightAction
	local FFAT = CoreFreeFlightAction.FreeFlightActionToggle
	local dp = FFA:new("Drop Player", callback(self, self, "drop_player"))
	local yc = FFA:new("Yield Control (F9 Exit)", callback(self, self, "yield_control"))
	local ef = FFA:new("Close", callback(self, self, "disable"))
	local ps = FFAT:new("Pause", "Unpause", callback(self, self, "pause_game"), callback(self, self, "unpause_game"))
	self._actions = {ps,dp,yc,ef}
	self._action_index = 1
end
function FreeFlightCamera:drop_player()
	local rot_new = Rotation(self._camera_rot:yaw(), 0, 0)
	game_state_machine:current_state():freeflight_drop_player(self._camera_pos, rot_new)
end
function FreeFlightCamera:yield_control()
	assert(self._state == FF_ON)
	self._state = FF_ON_NOCON
	self._con:disable()
end
function FreeFlightCamera:set_fov(value)
	self._camera_object:set_fov(value)
end
function FreeFlightCamera:set_game_speed(value)
	TimerManager:pausable():set_multiplier(value)
	TimerManager:game_animation():set_multiplier(value)	
end
function FreeFlightCamera:set_camera_speed(value)
	self._camera_speed = value
end
function FreeFlightCamera:pause_game() 
	Application:set_pause(true)
end
function FreeFlightCamera:quick_action_execute()
	self:current_action():do_action()
end
function FreeFlightCamera:next_modifier_toggle()
	if self:modifiers_are_visible() then
		self._modifier_gui[self._modifier_index]:child(0):set_color(DESELECTED)
		self._modifier_index = self._modifier_index % #self._modifiers + 1
		self._modifier_gui[self._modifier_index]:child(0):set_color(SELECTED)
	end
	self:draw_modifiers()
end
function FreeFlightCamera:curr_modifier_up()
	if self:modifiers_are_visible() then
		self:current_modifier():step_up()
		self._modifier_gui[self._modifier_index]:child(0):set_text(self:current_modifier():name_value())
		local _,_,w,h = self._modifier_gui[self._modifier_index]:child(0):text_rect()
		self._modifier_gui[self._modifier_index]:set_size(w + 2,h + 2)
		self._modifier_gui[self._modifier_index]:set_world_right(self._panel:world_right() - 45)  
	end
	self:draw_modifiers()
end
function FreeFlightCamera:curr_modifier_down()
	if self:modifiers_are_visible() then
		self:current_modifier():step_down()
		self._modifier_gui[self._modifier_index]:child(0):set_text(self:current_modifier():name_value())
		local _,_,w,h = self._modifier_gui[self._modifier_index]:child(0):text_rect()
		self._modifier_gui[self._modifier_index]:set_size(w + 2,h + 2)
		self._modifier_gui[self._modifier_index]:set_world_right(self._panel:world_right() - 45)  
	end
	self:draw_modifiers()
end
function FreeFlightCamera:modifiers_are_visible()
	local t = TimerManager:main():time()
	return self._modifier_vis_time and t + TEXT_FADE_TIME < self._modifier_vis_time
end
function FreeFlightCamera:unpause_game() 
	Application:set_pause(false)
end
function FreeFlightCamera:draw_actions()
	if not self:actions_are_visible() then
		for i, panel in ipairs(self._action_gui) do
			local text = panel:child(0)
			text:stop()
			panel:animate(panel:script().fade_in)
		end
	end
	for i, _ in ipairs(self._actions) do
		self._action_gui[i]:child(0):set_text(self._actions[i]:name())
		local _,_,w,h = self._action_gui[i]:child(0):text_rect()
		self._action_gui[i]:set_size(w + 2,h + 2)
	end
	self._action_vis_time = TimerManager:main():time() + TEXT_ON_SCREEN_TIME
end
function FreeFlightCamera:toggle_gui()
	if self:enabled() then
		if self._workspace:visible() then
			self._workspace:hide()
		else
			self._workspace:show()
		end
	end
end
function FreeFlightCamera:draw_modifiers()
	if not self:modifiers_are_visible() then
		for _, panel in ipairs(self._modifier_gui) do
			local text = panel:child(0)
			text:stop()
			panel:animate(panel:script().fade_in)
		end
	end
	self._modifier_vis_time = TimerManager:main():time() + TEXT_ON_SCREEN_TIME
end
function FreeFlightCamera:actions_are_visible()
	local t = TimerManager:main():time()
	return self._action_vis_time and t + TEXT_FADE_TIME < self._action_vis_time
end
function FreeFlightCamera:action_toggle()
	if self:actions_are_visible() then
		self._action_gui[self._action_index]:child(0):set_color(DESELECTED)
		self._action_index = self._action_index % #self._actions + 1
		self._action_gui[self._action_index]:child(0):set_color(SELECTED)
	end
	self:draw_actions()
end
function FreeFlightCamera:action_execute()
	if self:actions_are_visible() then
		self:current_action():do_action()
	end
	self:draw_actions()
end
function FreeFlightCamera:show_key_pressed() 
	if self._state == FF_ON then
		self:disable()
	elseif self._state == FF_OFF then
		self:enable()
	elseif self._state == FF_ON_NOCON then
		self._state = FF_ON
		self._con:enable()
	end
end
function FreeFlightCamera:current_action()
	return self._actions[self._action_index]
end
function FreeFlightCamera:enable()
	if true then
		local active_vp = managers.viewport:first_active_viewport()
		if active_vp then
			self._start_cam = active_vp:camera()
			if self._start_cam then
				local pos = self._start_cam:position() - (alive(self._attached_to_unit) and self._attached_to_unit:position() or Vector3())
				self:set_camera(pos, self._start_cam:rotation())
			end
		end
		self._state = FF_ON
		self._vp:set_active(true)
		self._con:enable()
		self._workspace:show()
		self:draw_actions()
		self:draw_modifiers()
		if managers.hud then
			managers.hud:hide(Idstring("guis/player_hud"))
			managers.hud:hide(Idstring("guis/player_info_hud_fullscreen"))
			managers.hud:hide(Idstring("guis/player_info_hud"))
			managers.hud:hide(Idstring("guis/experience_hud"))
		end  
	end
end
function FreeFlightCamera:disable()
	for _, id in pairs(self._trigger_ids) do
		Input:mouse():remove_trigger(id)
	end  
	Application:set_pause(false) 
	self._state = FF_OFF
	self._con:disable()
	self._workspace:hide()
	self._vp:set_active(false)
	if type(managers.enemy) == "table" then
		managers.enemy:set_gfx_lod_enabled(true)
	end
	if managers.hud then
		managers.hud:show(Idstring("guis/player_hud"))
		managers.hud:show(Idstring("guis/player_info_hud_fullscreen"))
		managers.hud:show(Idstring("guis/player_info_hud"))
		managers.hud:show(Idstring("guis/experience_hud"))
	end	   
end
function FreeFlightCamera:set_camera(pos, rot)
	if pos then
		self._camera_object:set_position((alive(self._attached_to_unit) and self._attached_to_unit:position() or Vector3()) + pos)
		self._camera_pos = pos
	end
	if rot then
		self._camera_object:set_rotation(rot)
		self._camera_rot = rot
	end
end
function FreeFlightCamera:current_modifier()
	return self._modifiers[self._modifier_index]
end
function FreeFlightCamera:paused_update(t, dt)
	self:update(t, dt)
end
function FreeFlightCamera:update_gui(t, dt)
	if self._action_vis_time and t > self._action_vis_time then
		for _, panel in ipairs(self._action_gui) do
			local text = panel:child(0)
			text:stop()
			panel:animate(panel:script().fade_out)
		end
		self._action_vis_time = nil
	end
	if self._modifier_vis_time and t > self._modifier_vis_time then
		for _, panel in ipairs(self._modifier_gui) do
			local text = panel:child(0)
			text:stop()
			panel:animate(panel:script().fade_out)
		end
		self._modifier_vis_time = nil
	end
end
function FreeFlightCamera:update_camera(t, dt)
	local axis_move = self._con:get_input_axis("freeflight_axis_move")
	local axis_look = self._con:get_input_axis("freeflight_axis_look")
	local btn_move_up = self._con:get_input_float("freeflight_move_up")
	local btn_move_down = self._con:get_input_float("freeflight_move_down")
	local move_dir = self._camera_rot:x() * axis_move.x + self._camera_rot:y() * axis_move.y
	move_dir = move_dir + btn_move_up * Vector3(0, 0, 1) + btn_move_down * Vector3(0, 0, -1)
	local move_delta = move_dir * self._move_speed:value() * MOVEMENT_SPEED_BASE * dt
	local pos_new = self._camera_pos + move_delta
	local yaw_new = self._camera_rot:yaw() + axis_look.x * -1 * self._turn_speed:value() * TURN_SPEED_BASE
	local pitch_new = math.clamp(self._camera_rot:pitch() + axis_look.y * self._turn_speed:value() * TURN_SPEED_BASE, PITCH_LIMIT_MIN, PITCH_LIMIT_MAX)
	local rot_new = Rotation(yaw_new, pitch_new, 0)
	if not CoreApp.arg_supplied("-vpslave") then
		self:set_camera(pos_new, rot_new)
	end
end
function FreeFlightCamera:update(t, dt)
	local main_t = TimerManager:main():time()
	local main_dt = TimerManager:main():delta_time()	
	if self:enabled() then
		if true then
			self:update_camera(main_t, main_dt)
			self:update_gui(main_t, main_dt)
		else
			self:disable()
		end
	end
end
function FreeFlightCamera:enabled()
	return self._state ~= FF_OFF
end
if GameSetup then
	local paused_update_for_camera = GameSetup.paused_update	
	function GameSetup:paused_update(t, dt)
		paused_update_for_camera(self, t, dt)
		FreeFlightCamera:update(t, dt)
	end
	
	local update_for_camera = GameSetup.update	
	function GameSetup:update(t, dt)
		update_for_camera(self, t, dt)
		FreeFlightCamera:update(t, dt)
	end
	
	local init_managers_for_camera = GameSetup.init_managers	
	function GameSetup:init_managers(...)
		init_managers_for_camera(self, ...)
		FreeFlightCamera:init()
	end
end
