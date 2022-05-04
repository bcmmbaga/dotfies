-- [[ opts.lua ]]

local opt = vim.opt
local cmd = vim.api.nvim_command

vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
vim.api.nvim_exec([[ autocmd CursorHold * silent call CocActionAsync('highlight') ]], false)
vim.api.nvim_exec([[ autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'Pipfile'] ]], false)


-- [[ Context ]]
opt.colorcolumn = '80'           -- Show col for max line length
opt.number = true                -- Show line numbers
opt.relativenumber = false       -- Show relative line numbers
opt.scrolloff = 4                -- Min num lines of context  
opt.cmdheight=4                  -- More space for displaying messages
opt.signcolumn = "yes"           -- Show the sign column

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- String encoding to use
opt.fileencoding = 'utf8'        -- File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                -- Allow syntax highlighting
opt.termguicolors = true         -- If term supports ui color then enable
cmd('colorscheme gruvbox')

-- [[ Search ]]
opt.ignorecase = true            -- Ignore case in search patterns
opt.smartcase = true             -- Override ignorecase if search contains capitals
opt.incsearch = true             -- Use incremental search
opt.hlsearch = false             -- Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true             -- Use spaces instead of tabs
opt.shiftwidth = 4               -- Size of an indent
opt.softtabstop = 4              -- Number of spaces tabs count for in insert mode
opt.tabstop = 4                  -- Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true            -- Place new window to right of current one
opt.splitbelow = true            -- Place new window below the current one


vim.g.bufferline = {
    -- Enable/disable animations
    animation = true,
  
    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,
  
    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,
  
    -- Enable/disable close button
    closable = true,
  
    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = true,
  
    -- Excludes buffers from the tabline
    exclude_ft = {'javascript'},
    exclude_name = {'package.json'},
  
    -- Enable/disable icons
    -- if set to 'numbers', will show buffer index in the tabline
    -- if set to 'both', will show buffer index and icons in the tabline
    icons = true,
  
    -- If set, the icon color will follow its corresponding buffer
    -- highlight group. By default, the Buffer*Icon group is linked to the
    -- Buffer* group (see Highlighting below). Otherwise, it will take its
    -- default value as defined by devicons.
    icon_custom_colors = false,
  
    -- Configure icons on the bufferline.
    icon_separator_active = '▎',
    icon_separator_inactive = '▎',
    icon_close_tab = '',
    icon_close_tab_modified = '●',
    icon_pinned = '車',
  
    -- If true, new buffers will be inserted at the start/end of the list.
    -- Default is to insert after current buffer.
    insert_at_end = false,
    insert_at_start = false,
  
    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,
  
    -- Sets the maximum buffer name length.
    maximum_length = 30,
  
    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,
  
    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustement
    -- for other layouts.
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  
    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
  }