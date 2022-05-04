-- Options
-- ==================================================
vim.g.mapleader = ","

vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.splitright = true
-- Hybrid - Both nonrelative and relative numbering if both are true.
vim.opt.number = true
-- Set relativenumber to false to have fixed numbering.
vim.opt.relativenumber = false
-- ==================================================


-- Colorscheme settings
-- ==================================================
vim.cmd([[
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1
colorscheme sonokai
]])
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
--local servers = {'pyright'}
--for _, lsp in pairs(servers) do
--  require('lspconfig')[lsp].setup {
--    on_attach = on_attach,
--    flags = {
--      -- This will be the default in neovim 0.7+
--      debounce_text_changes = 150,
--    }
--  }
--end
-- ==================================================


-- Nvim-treesitter settings
-- ==================================================
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp", "lua", "python"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
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
