vim.g.mapleader = ","

vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.splitright = true

-- Colorscheme settings
-- ==================================================
vim.cmd([[
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1
colorscheme sonokai
]])
-- ==================================================

-- Nvim-tree settings
-- ==================================================
require'nvim-tree'.setup {
  auto_reload_on_write = true,
  hijack_cursor = false,
  open_on_setup = false,
  open_on_tab = false,
  sort_by = "name",
  renderer = {
    icons = {
      webdev_colors = true,
    },
  },
  filters = {
    dotfiles = false,
    exclude = {},
  },
}
-- ==================================================
-- lualine settings
-- ==================================================
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'OceanicNext',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '|', right = '|'},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
-- ==================================================
-- Lsp settings
-- ==================================================

-- ==================================================
