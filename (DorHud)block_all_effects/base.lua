local module = DMod:new("block_all_effects", {
	abbr = "blockalleffects",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/26328/",
	version = "1"
})

module:hook_post_require("lib/entry", "entry")

return module