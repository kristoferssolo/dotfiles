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
