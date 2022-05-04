-- [[ keys.lua ]]

local map = vim.api.nvim_set_keymap

-- Toggle nvim-tree
map('n', 'n', ':NvimTreeToggle<CR>', {})
map('n', 'ff', [[:Telescope find_files]], {})


-- coc key bindings
map('n', 'gd', '<Plug>(coc-definition)', {silent=true})                              -- go to definition
map('n', 'gi', '<Plug>(coc-implementation)', {silent=true})                          -- go to implementation
map('n', 'gy', '<Plug>(coc-type-definition)', {silent=true})                         -- go to type definition
map('n', 'gr', '<Plug>(coc-references)', {silent=true})                              -- go to references
map('n', '<leader>cl',  '<Plug>(coc-codelens-action)', {silent=true})                           -- trigger code lens
map('n', '<leader>rn', '<Plug>(coc-rename)', {})                                     -- rename
map('n', '<C-L>', ':nohlsearch<CR><C-L>', {silent=true})                           -- remove highlight after serch
map('n', '<C-I> ', ':CocCommand python.sortImports<CR><C-I>', {silent=true})         -- sort and arrang python packages