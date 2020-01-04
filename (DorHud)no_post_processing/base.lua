local module = DMod:new("no_post_processing", {
	abbr = "nopostprocessing",
	author = "Dr_Newbie",
	description = "http://modwork.shop/",
	version = "2"
})

module:hook_post_require("core/lib/managers/managerbase/coremanagerbase", "coremanagerbase")

return module