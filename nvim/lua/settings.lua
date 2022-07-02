local api = vim.api
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

opt.number = true -- Show line numbers
opt.relativenumber = false -- Show relative line numbers
opt.scrolloff = 4 -- Min num lines of context
opt.cmdheight = 4 -- More space for displaying messages
opt.signcolumn = "yes" -- Show the sign column
opt.encoding = "utf-8" -- String encoding to use
opt.fileencoding = "utf8" -- File encoding to use
opt.syntax = "ON" -- Allow syntax highlighting
opt.termguicolors = true -- If term supports ui color then enable
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search contains capitals
opt.incsearch = true -- Use incremental search
opt.hlsearch = false -- Highlight search matches
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Size of an indent
opt.softtabstop = 4 -- Number of spaces tabs count for in insert mode
opt.tabstop = 4 -- Number of spaces tabs count for
opt.splitright = true -- Place new window to right of current one
opt.splitbelow = true -- Place new window below the current one
opt.cursorline = true -- Highlight line under cursor. It helps with navigation.

g.t_co = 256
g.background = "dark"
-- g.gruvbox_material_foreground = "original"
-- g.gruvbox_material_background = "soft"

opt.fillchars:append({ eob = " " })
-- g.sonokai_style = 'maia'
g.sonokai_better_performance = 1

cmd("colorscheme gruvbox-material") -- Set colorscheme

-- cmd("set noswapfile")                  -- Disable swap to prevent annoying messages.
-- cmd("set list lcs=tab:\\│\\ ,eol:↴")   -- List mode: Show tabs as CTRL-I is displayed, display $ after end of line.
cmd("syntax on") -- See :h :syntax-on
cmd("set mouse+=a")

vim.g.mapleader = "," -- Leader map

-- Quick mappings
api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true })
api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true })
api.nvim_set_keymap("n", "<c-d>", "dd", { noremap = true })
api.nvim_set_keymap("n", "²", "0", { noremap = true })
api.nvim_set_keymap("n", "<space>", "i<space><esc>", { noremap = true })

local nvim_tree_events = require("nvim-tree.events")
local bufferline_state = require("bufferline.state")

nvim_tree_events.on_tree_open(function()
	bufferline_state.set_offset(31, "File Tree")
end)

nvim_tree_events.on_tree_close(function()
	bufferline_state.set_offset(0)
end)
require("nvim-tree").toggle(false, true)

g.go_gopls_enabled = false
