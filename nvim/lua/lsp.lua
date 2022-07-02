local lspconfig = require("lspconfig")

--- Document highlights
local function document_highlight()
	vim.api.nvim_exec(
		[[
		hi LspReferenceRead  guibg=#121111 guifg=#FFFF00
		hi LspReferenceText  guibg=#121111 guifg=#FFFF00
		hi LspReferenceWrite guibg=#121111 guifg=#FFFF00
		augroup lsp_document_highlight
			autocmd!
			autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
	]],
		false
	)
end

--- Custom attach
local on_attach_vim = function()
	document_highlight()
	vim.keymap.set("n", "<leader>dc", ":Telescope diagnostics bufnr=0<cr>")
	vim.keymap.set("n", "<leader>gr", ":Telescope lsp_references<cr>", { buffer = 0 })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = false, -- Enable underline, use default values
	virtual_text = false, -- Enable virtual text only on Warning or above, override spacing to 2
})

-- PYRIGHT {{{

local python_root_files = {
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"pyrightcon",
}

require("lspconfig").pyright.setup({
	on_attach = on_attach_vim,
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
	cmd = { "pyright-langserver", "--stdio" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

-- }}}

-- gopls {{{

lspconfig.gopls.setup({
	on_attach = on_attach_vim,
	capabilities = capabilities,
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			linksInHover = false,
			codelenses = {
				generate = true,
				gc_details = true,
				regenerate_cgo = true,
				tidy = true,
				upgrade_depdendency = true,
				vendor = true,
			},
			usePlaceholders = true,
		},
	},
})

function goimports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				-- note: text encoding param is required
				vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

vim.cmd([[
  augroup GO_LSP
	  autocmd!
	  autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()
	  autocmd BufWritePre *.py :silent! lua vim.lsp.buf.formatting()
	  autocmd BufWritePre *.go :silent! lua goimports(3000)
  augroup END
  ]])
-- }}}

-- Golangci-lint {{{

lspconfig.golangci_lint_ls.setup({})

-- }}}
