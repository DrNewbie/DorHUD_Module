local module = ... or DorHUD:module("test_place")
local MenuNodeGui = module:hook_class("MenuNodeGui")

local check_heist_name = {}

for __id, _ in pairs(module.__allow_heist) do
	check_heist_name["pick_"..__id] = true
end

module:post_hook(MenuNodeGui, "_setup_panels", function(self, node)
	if node and tostring(node:parameters().name) == "play_single_player" then
		self.__node_play_single_player = true
	end
end, true)

module:post_hook(MenuNodeGui, "_create_menu_item", function(self, row_item)
	if self.__node_play_single_player and row_item.type == "toggle" and row_item.gui_text and check_heist_name[tostring(row_item.name)] then
		row_item.gui_text:set_text(string.upper(
			"Test Map - "..row_item.gui_text:text()
		))
	end
end, true)