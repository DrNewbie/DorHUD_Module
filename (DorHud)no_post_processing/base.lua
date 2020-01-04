local module = DMod:new("no_post_processing", {
	abbr = "nopostprocessing",
	author = "Dr_Newbie",
	description = "https://modworkshop.net/mod/26329/",
	version = "1"
})

module:hook_post_require("core/lib/managers/managerbase/coremanagerbase", "coremanagerbase")

return module