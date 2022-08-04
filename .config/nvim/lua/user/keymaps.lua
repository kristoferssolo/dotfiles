local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remmove default keymaps
keymap("n", "<S-j>", "<Nop>", opts)

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Shortcutting split navigation
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- Resize with arrows
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- Move text up and down.
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", opts)
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<Esc>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down. Visual mode
-- keymap("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", opts)
-- keymap("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", opts)
keymap("v", "p", "'_dP'", opts)

-- Visual Block --
-- Move text up and down.
-- keymap("x", "K", "<cmd>m '>+1<CR>gv=gv", opts)
-- keymap("x", "J", "<cmd>m '<-2<CR>gv=gv", opts)
-- keymap("x", "<A-k>", "<cmd>m '<-2<CR>gv=gv", opts)
-- keymap("x", "<A-j>", "<cmd>m '>+1<CR>gv=gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Shortcutting --
-- Substitute
keymap("n", "S", ":%s//<Left>", {})
