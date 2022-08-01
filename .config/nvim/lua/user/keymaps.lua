local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Shortcutting split navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', '<cmd>resize -2<CR>', opts)
keymap('n', '<C-Down>', '<cmd>resize +2<CR>', opts)
keymap('n', '<C-Left>', '<cmd>vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', '<cmd>vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', '<cmd>bnext<CR>', opts)
keymap('n', '<S-h>', '<cmd>bprevious<CR>', opts)

-- Move text up and down
keymap('n', '<A-j>', '<Esc><cmd>m .+1<CR>==gi', opts)
keymap('n', '<A-k>', '<Esc><cmd>m .-2<CR>==gi', opts)

-- Insert --
-- Press jk fast to exit insert mode 
keymap('i', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '<A-j>', '<cmd>m .+1<CR>==', opts)
keymap('v', '<A-k>', '<cmd>m .-2<CR>==', opts)
keymap('v', 'p', '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', '<cmd>move ">+1<CR>gv-gv', opts)
keymap('x', 'K', '<cmd>move "<-2<CR>gv-gv', opts)
keymap('x', '<A-j>', '<cmd>move ">+1<CR>gv-gv', opts)
keymap('x', '<A-k>', '<cmd>move "<-2<CR>gv-gv', opts)

-- Terminal --
-- Better terminal navigation
-- keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
-- keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
-- keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
-- keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

keymap('n', '<leader>n', ':NvimTreeFocus<CR>', opts)
keymap('n', 'C-t', ':NvimTreeToggle<CR>', opts)
keymap('n', 'C-f', ':NvimTreeFindFile<CR>', opts)
keymap('n', '<F5>', ':NvimTreeRefresh<CR>', opts)

-- Enable/Disable auto comment
keymap('', '<leader>c', '<cmd>setlocal formatoption-=CRo<cr>', {})
keymap('', '<leader>C', '<cmd>setlocal formatoption=CRo<cr>', {})

-- Enable spell checking, s for spell check
keymap('', '<leader>s', '<cmd>setlocal spell! spelllang=eu_us<CR>', {})

-- Enable / Disable auto indent
keymap('', '<leader>i', '<cmd>setlocal autoindent<CR>', {})
keymap('', '<leader>I', '<cmd>setlocal noautoindent<CR>', {})

-- Moving line up or down by one line
keymap('', '<A-k>', '<cmd>m -2<CR>', opts)
keymap('', '<A-up>', '<cmd>m -2<CR>', opts)
keymap('', '<A-j>', '<cmd>m +1<CR>', opts)
keymap('', '<A-down>', '<cmd>m +1<CR>', opts)

-- Find files using Telescope command-line
keymap('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<CR>', opts)
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)

-- Alias 'replace all' to S
keymap('n', 'S', '<cmd>s%//<Left>', opts)


-- " run current script with python3 by CTRL+R in command and insert mode
-- autocmd FileType python map <buffer> <C-r> <cmd>w<CR><cmd>exec '!python3' shellescape(@%, 1)<CR>
-- autocmd FileType python imap <buffer> <C-r> <esc><cmd>w<CR><cmd>exec '!python3' shellescape(@%, 1)<CR>
-- autocmd FileType rust map <buffer> <C-r> <cmd>w<CR><cmd>exec '!cargo run'<CR>
-- autocmd FileType rust imap <buffer> <C-r> <cmd>w<CR><cmd>exec '!cargo run'<CR>

-- autocmd BufWritePre,InsertLeave *.{py,rs,html,css,md,lua} Neoformat
-- let g:neoformat_enabled_python = ['autopep8']
-- let g:neoformat_try_node_exe = 1

