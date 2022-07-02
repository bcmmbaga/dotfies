require("colors")
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local fn = vim.fn
local api = vim.api

-- Diagnostics {{{

fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticHint" })
fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticError" })
fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticWarn" })
fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticInfo" })

api.nvim_command("hi DiagnosticError guifg=" .. CONIFER)
api.nvim_command("hi DiagnosticWarn  guifg=" .. GOLD)
api.nvim_command("hi DiagnosticHint  guifg=" .. BRILLIANT_ROSE)

api.nvim_command("hi DiagnosticVirtualTextError guifg=Red")
api.nvim_command("hi DiagnosticVirtualTextWarn  guifg=Yellow")
api.nvim_command("hi DiagnosticVirtualTextInfo  guifg=White")
api.nvim_command("hi DiagnosticVirtualTextHint  guifg=White")

api.nvim_command("hi DiagnosticUnderlineError guifg=NONE gui=underline")
api.nvim_command("hi DiagnosticUnderlineWarn  guifg=NONE gui=underline")
api.nvim_command("hi DiagnosticUnderlineInfo  guifg=NONE gui=underline")
api.nvim_command("hi DiagnosticUnderlineHint  guifg=NONE gui=underline")

vim.keymap.set("n", "<C-e>", vim.diagnostic.open_float)

-- }}}

-- NvimTree {{{
require("nvim-tree").setup({
	view = {
		signcolumn = "yes",
		-- hide_root_folder = true,
	},
	filters = {
		dotfiles = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
})

-- }}}

-- lualine {{{

require("lualine").setup()

-- }}}

-- Tree-sitter {{{

require("nvim-treesitter.configs").setup({
	ensure_installed = "python",
	"go",
	"pyright",
	highlight = {
		enable = true, -- false will disable the whole extension
	},
})

-- }}}

-- Bufferline {{{

map("n", "pt", [[ :BufferPrevious<CR> ]], opts)
map("n", "nt", [[ :BufferNext<CR> ]], opts)
map("n", "ct", [[ :BufferClose<CR> ]], opts)

require("bufferline").setup({
	animation = true,
	auto_hide = true,
	closable = true,
	clickable = true,
})

-- }}}

-- Telescope {{{

map("n", "ff", [[:Telescope find_files<CR>]], opts)
vim.keymap.set("n", "<Leader>gr", ":Telescope lsp_references<cr>", { buffer = 0 })
vim.keymap.set("n", "<Leader>dc", ":Telescope diagnostics<cr>", { buffer = 0 })

api.nvim_command("hi TelescopeSelection guifg=#FFFF00 gui=bold")
api.nvim_command("hi TelescopeNormal guibg=#00000F")
api.nvim_command("hi TelescopeMatching guifg=#A7EC21")

require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = ">",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0,
		layout_config = {
			width = 0.75,
			preview_cutoff = 120,
			prompt_position = "top",
		},
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		scroll_strategy = "cycle",
		set_env = { ["COLORTERM"] = "truecolor" }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
		file_previewer = require("telescope.previewers").cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
		grep_previewer = require("telescope.previewers").vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
		qflist_previewer = require("telescope.previewers").qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
})
-- }}}

-- LSP Config {{{

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "rn", vim.lsp.buf.rename)

-- }}}

-- nvim-cmp {{{

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require("cmp")

local icons = {
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = "識",
	Variable = "𝑋 ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = "﬌ ",
	Color = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = " ",
	Event = " ",
	Operator = "ﬦ",
	TypeParameter = " ",
}

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },

		format = function(_, vim_item)
			vim_item.menu = vim_item.kind
			vim_item.kind = icons[vim_item.kind]

			return vim_item
		end,
	},

	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},

	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),

		["<Down>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<Up>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["UltiSnips#CanJumpForwards"](-1) == 1 then
				vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
			end
		end, { "i", "s" }),
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
		{ name = "ultisnips" },
	},
})

api.nvim_command(" highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
api.nvim_command(" highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6")
api.nvim_command(" highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6")
api.nvim_command(" highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE")
api.nvim_command(" highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE")
api.nvim_command(" highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE")
api.nvim_command(" highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0")
api.nvim_command(" highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0")
api.nvim_command(" highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4")
api.nvim_command(" highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4")
api.nvim_command(" highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4")

-- }}}

-- pears.nvim {{{

require("pears").setup(function(conf)
	conf.pair("{", "}")
	conf.expand_on_enter(true)
	conf.preset("tag_matching")
end)

-- }}}

-- NULL-LS {{{
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- null_ls.builtins.diagnostics.mypy,
		-- null_ls.builtins.diagnostics.pydocstyle,
		null_ls.builtins.diagnostics.pylint,
		-- null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
-- }}}

-- gitsigns {{{
require("gitsigns").setup()
-- }}}
