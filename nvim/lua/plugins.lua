-- [[ plugins.lua ]]

return require('packer').startup({function(use)

  -- file-explorer with icons
  use {     
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'    
  }
  
  -- gruvbox theme
  use { "ellisonleao/gruvbox.nvim" }

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- git intergration
  use { 'tpope/vim-fugitive' }

  -- conquer of completion
  use {'neoclide/coc.nvim', branch = 'release'}

  -- vim-go additional go features
  use { "fatih/vim-go" }
  end,
  config = {
    package_root = vim.fn.stdpath('config') .. '/site/pack'
  }})
