-- Run :PackerCompile whenever plugins.lua is updated.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

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
  use 'neovim/nvim-lspconfig'
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
  -- ==================================================

end)

