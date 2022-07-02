-- [[ plugins.lua ]]

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim") -- Package manager

		use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP

		-- file explorer
		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons", -- optional, for file icons
			},
		})

		-- tabs
		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
		})

		-- Completion
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lsp-signature-help")
		use("hrsh7th/cmp-nvim-lua")
		use("SirVer/ultisnips")
		use("quangnguyen30192/cmp-nvim-ultisnips")

		use("steelsojka/pears.nvim")

		-- gruvbox theme
		use({ "sainnhe/gruvbox-material" })

		-- status line
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		--   -- fuzzy finder
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		-- git intergration
		use({ "tpope/vim-fugitive" })
		use("lewis6991/gitsigns.nvim")

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})
		use("jose-elias-alvarez/null-ls.nvim")
		-- conquer of completion
		-- use {'neoclide/coc.nvim', branch = 'release'}

		-- -- vim-go
		use({ "fatih/vim-go" })

		use({ "ggandor/lightspeed.nvim" })
	end,
	config = {
		package_root = vim.fn.stdpath("config") .. "/site/pack",
	},
})
