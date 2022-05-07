-- [[ util.lua ]]


local exec = vim.api.nvim_exec

exec([[ autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport') ]], false)
exec([[ autocmd CursorHold * silent call CocActionAsync('highlight') ]], false)

-- Start NERDTree when Vim is started without file arguments.
exec([[ autocmd StdinReadPre * let s:std_in=1 ]], false)
exec([[ autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif ]], false)
-- Exit Vim if NERDTree is the only window remaining in the only tab.
exec([[ autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif ]], false)

exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
exec([[ autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'Pipfile'] ]], false)