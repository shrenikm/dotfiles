-- Options
-- ==================================================
vim.g.mapleader = ","

vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.splitright = true

-- Hybrid - Both nonrelative and relative numbering if both are true.
vim.opt.number = true
-- Set relativenumber to false to have fixed numbering.
vim.opt.relativenumber = false

-- Sync nvim and OS clipboards
vim.opt.clipboard = 'unnamedplus'
-- Save undo history
vim.opt.undofile = true

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

-- -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Search highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Set clipboard
vim.o.clipboard = "unnamedplus"

