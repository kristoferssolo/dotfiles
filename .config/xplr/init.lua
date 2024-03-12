---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.
---@diagnostic enable

-- This is the built-in configuration file that gets loaded and sets the
-- default values when xplr loads, before loading any other custom
-- configuration file.
--
-- You can use this file as a reference to create a your custom config file.
--
-- To create a custom configuration file, you need to define the script version
-- for compatibility checks.
--
-- See https://xplr.dev/en/upgrade-guide
--
-- ```lua
version = "0.21.3"

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

require("xpm").setup({
	plugins = {
		"dtomvan/xpm.xplr",
		"sayanarijit/fzf.xplr",
		"prncss-xyz/icons.xplr",
		"sayanarijit/xclip.xplr",
		"sayanarijit/trash-cli.xplr",
		"sayanarijit/scp.xplr",
		"sayanarijit/qrcp.xplr",
		"sayanarijit/preview-tabbed.xplr",
		"dtomvan/ouch.xplr",
		"sayanarijit/nvim-ctrl.xplr",
		"Junker/nuke.xplr",
		"sayanarijit/fzf.xplr",
		"sayanarijit/dragon.xplr",
		"sayanarijit/alacritty.xplr",
		"sayanarijit/tri-pane.xplr",
		"sayanarijit/map.xplr",
	},
	auto_install = true,
	auto_cleanup = true,
})
