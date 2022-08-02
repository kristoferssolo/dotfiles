local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", "<cmd>Telescope find_files hidden=true<CR>"),
	dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert hidden=true<CR>"),
	dashboard.button("p", "  Find project", "<cmd>Telescope projects<CR>"),
	dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles<CR>"),
	dashboard.button("t", "  Find text", "<cmd>Telescope live_grep hidden=true<CR>"),
	dashboard.button("c", "  Configuration", "<cmd>e ~/.config/nvim/init.lua<CR>"),
	dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
}

local function footer()
	-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen('fortune')
	-- local fortune = handle:read('*a')
	-- handle:close()
	-- return fortune
	return ""
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
