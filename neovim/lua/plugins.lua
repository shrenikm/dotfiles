-- TODO: Rm the vimrc autocmd once it is established that the lua one works.
--vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--  augroup end
--]])
-- Run :PackerCompile whenever plugins.lua is updated.
local packer_compile_augroup = vim.api.nvim_create_augroup('packer_use_config', {clear = true})
vim.api.nvim_create_autocmd({'BufWritePost'}, {
  pattern = 'plugins.lua',
  group = packer_compile_augroup,
  command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function()
  -- Packer itself
  -- ==================================================
  use 'wbthomason/packer.nvim'
  -- ==================================================


  -- Color schemes
  -- ==================================================
  use 'sainnhe/sonokai'
  -- ==================================================


  -- UI plugins
  -- ==================================================
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- ==================================================


  -- Functional plugins
  -- ==================================================
  -- Collection of configurations for built-in LSP client
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use {
    'psf/black',
    branch = 'stable',
  }
  --use 'fisadev/vim-isort'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-path' -- Filesystem path completion
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  -- Note that it is good to install fd and ripgrep for telescope
  -- (sudo apt install fd-find)
  -- (sudo apt-get install ripgrep)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  -- ==================================================

end)

