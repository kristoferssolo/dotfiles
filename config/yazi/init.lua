require("relative-motions"):setup({ show_numbers = "relative", show_motion = true })
require("full-border"):setup()
require("augment-command"):setup({
	prompt = false,
	default_item_group_for_prompt = "hovered",
	smart_enter = true,
	smart_paste = false,
	smart_tab_create = false,
	smart_tab_switch = false,
	open_file_after_creation = false,
	enter_directory_after_creation = false,
	use_default_create_behaviour = false,
	enter_archives = true,
	extract_retries = 3,
	recursively_extract_archives = true,
	preserve_file_permissions = false,
	must_have_hovered_item = true,
	skip_single_subdirectory_on_enter = false,
	skip_single_subdirectory_on_leave = false,
	wraparound_file_navigation = false,
})
require("git"):setup()
-- require("yatline"):setup({
-- 	show_background = false,
-- 	section_separator = { open = "", close = "" },
-- 	part_separator = { open = "", close = "" },
-- 	inverse_separator = { open = "", close = "" },
--
-- 	header_line = {
-- 		left = {
-- 			section_a = {
-- 				{ type = "line", custom = false, name = "tabs", params = { "left" } },
-- 			},
-- 			section_b = {},
-- 			section_c = {},
-- 		},
-- 		right = {
-- 			section_a = {
-- 				{ type = "string", custom = false, name = "date", params = { "%A, %d %B %Y" } },
-- 			},
-- 			section_b = {
-- 				{ type = "string", custom = false, name = "date", params = { "%X" } },
-- 			},
-- 			section_c = {},
-- 		},
-- 	},
--
-- 	status_line = {
-- 		left = {
-- 			section_a = {},
-- 			section_b = {},
-- 			section_c = {
-- 				{ type = "string", custom = false, name = "hovered_path" },
-- 				{ type = "coloreds", custom = false, name = "task_states" },
-- 			},
-- 		},
-- 		right = {
-- 			section_a = {
-- 				{ type = "string", custom = false, name = "cursor_position" },
-- 				{ type = "string", custom = false, name = "cursor_percentage" },
-- 			},
-- 			section_b = {
-- 				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
-- 			},
-- 			section_c = {
-- 				{ type = "coloreds", custom = false, name = "permissions" },
-- 				{ type = "coloreds", custom = false, name = "count", params = "true" },
-- 			},
-- 		},
-- 	},
-- })
