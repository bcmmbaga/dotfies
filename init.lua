local packer_path = vim.fn.stdpath("config") .. "/site"
vim.o.packpath = vim.o.packpath .. "," .. packer_path

require("config") -- Variables
require("settings") -- Options
require("plugins") -- Plugins
require("lsp")
