-- Run :PackerCompile whenever plugins.lua is updated.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
  -- Packer itself.
  use 'wbthomason/packer.nvim'

  -- Color schemes.
  -- ==================================================
  use 'sainnhe/sonokai'
  -- ==================================================

end)

