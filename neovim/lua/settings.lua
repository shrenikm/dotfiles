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

-- Default tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Language specific tabs.
-- TODO: Is there a better way to do this?
local python_tab_augroup = vim.api.nvim_create_augroup('python_tab_augroup', {clear = true})
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'python',
  group = python_tab_augroup,
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end
})


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
-- TODO: Ideally we have the lsp settings here.
-- local servers = {'pyright'}
-- for _, lsp in pairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
-- end
-- ==================================================


-- Nvim-cmp and luasnip settings.
-- ==================================================
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- cmp-path
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
-- ==================================================


-- Nvim-treesitter settings
-- ==================================================
require('nvim-treesitter.configs').setup {
  ensure_installed = {"cpp", "lua", "python"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
-- ==================================================


-- Nvim-tree settings
-- ==================================================
require('nvim-tree').setup {
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


-- Telescope settings
-- ==================================================
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
  },
  extensions = {
  }
}
-- ==================================================


-- ISort settings
-- ==================================================
-- TODO: Rm as pyproject.toml works
-- vim.cmd([[
-- let g:vim_isort_config_overrides = {
--   \ 'include_trailing_comma': 1,
--   \ 'multi_line_output': 3}
-- ]])
-- ==================================================
