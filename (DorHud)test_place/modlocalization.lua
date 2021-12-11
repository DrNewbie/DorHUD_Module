local module = ... or DorHUD:module('test_place')

module:add_localization_string("test_place_level_briefing", {
	english = table.concat({
		"This heist is modified to testing.",
		"This heist is modified to testing.",
		"This heist is modified to testing.",
		"This heist is modified to testing.",
		"This heist is modified to testing."
	}, "\n\n")
})