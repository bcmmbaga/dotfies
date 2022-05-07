-- [[ plugins.lua ]]

return require('packer').startup({function(use)

  -- file-explorer with icons
  use {     
    'preservim/nerdtree',
  }
  use {
    'ryanoasis/vim-devicons'
  }
  
  -- gruvbox theme
  use { 'sainnhe/gruvbox-material' }

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

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- conquer of completion
  use {'neoclide/coc.nvim', branch = 'release'}

  -- vim-go additional go features
  use { "fatih/vim-go" }

  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

  use { 'ggandor/lightspeed.nvim' }

  use { 'RRethy/vim-illuminate' }

  use {"ellisonleao/glow.nvim", branch = 'main'}
  end,
  config = {
    package_root = vim.fn.stdpath('config') .. '/site/pack'
  }})
