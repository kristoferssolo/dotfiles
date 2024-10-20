require("relative-motions"):setup({ show_numbers = "relative", show_motion = true })
require("full-border"):setup()
require("augment-command"):setup({
	prompt = false,
	default_item_group_for_prompt = "hovered",
	smart_enter = true,
	smart_paste = false,
	enter_archives = true,
	extract_behaviour = "skip",
	must_have_hovered_item = true,
	skip_single_subdirectory_on_enter = false,
	skip_single_subdirectory_on_leave = false,
	ignore_hidden_items = false,
	wraparound_file_navigation = false,
})
require("git"):setup()
