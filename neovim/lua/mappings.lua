function map(mode, shortcut, command, noremap, unique)
  vim.api.nvim_set_keymap(mode, shortcut, command,
    { noremap = noremap, unique = unique, silent = true }
  )
end

function unmap(mode, shortcut)
  vim.api.nvim_del_keymap(mode, shortcut)
end

function buf_map(bufnr, mode, shortcut, command, noremap, unique)
  vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, command,
    { noremap = noremap, unique=unique, silent = true }
  )
end

function buf_unmap(bufnr, mode, shortcut)
  vim.api.nvim_buf_del_keymap(bufnr, mode, shortcut)
end


-- Unique nmap
function nmap_u(shortcut, command)
  map('n', shortcut, command, false, true)
end

-- Non unique nmap
function nmap_nu(shortcut, command)
  map('n', shortcut, command, false, false)
end

-- Unique nnoremap
function nnoremap_u(shortcut, command)
  map('n', shortcut, command, true, true)
end

-- Non unique nnoremap
function nnoremap_nu(shortcut, command)
  map('n', shortcut, command, true, false)
end

-- Unique nnoremap
function buf_nnoremap_u(bufnr, shortcut, command)
  buf_map(bufnr, 'n', shortcut, command, true, true)
end

-- Non unique nnoremap
function buf_nnoremap_nu(bufnr, shortcut, command)
  buf_map(bufnr, 'n', shortcut, command, true, false)
end

-- Load nvim mappings
-- =============================================
nnoremap_u("<leader>sv", ":source ~/.config/nvim/init.lua<CR>")
-- =============================================

-- Save and close mappings
-- =============================================
nnoremap_u("<leader>w", ":w<cr>")
nnoremap_u("<leader>q", ":q<cr>")
-- =============================================


-- Scroll mappings
-- =============================================
nnoremap_u("<leader>md", "25<c-e>") -- Scroll down 25 lines
nnoremap_u("<leader>me", "25<c-y>") -- Scroll up 25 lines
-- =============================================


-- Newline mappings
-- =============================================
nnoremap_u("<leader>no", "o<Esc>") -- Insert a line below and go to normal mode
nnoremap_u("<leader>nO", "O<Esc>") -- Insert a line above and go to normal mode
-- =============================================


-- Buffer mappings
-- =============================================
nnoremap_u("<leader>bl", ":bnext<cr>") -- Next buffer
nnoremap_u("<leader>bh", ":bprevious<cr>") -- Previous buffer

-- Rather than just closing, we close and bring up the previous buffer.
-- Maybe also consider :bp|bd#
-- close buffer but keep the window and replace with the next buffer
nnoremap_u("<leader>bk", ":bp<bar>sp<bar>bn<bar>bd<CR>")
nnoremap_u("<leader>bK", ":bd<cr>") -- Close buffer along with the tab
-- =============================================



-- Window mappings
-- =============================================
nnoremap_u("<leader>sh", "<c-w>h")
nnoremap_u("<leader>sl", "<c-w>l")
nnoremap_u("<leader>sj", "<c-w>j")
nnoremap_u("<leader>sk", "<c-w>k")
-- =============================================


-- Tab mappings
-- =============================================
nnoremap_u("<leader>tl", ":tabn<cr>") -- Next tab
nnoremap_u("<leader>th", ":tabp<cr>") -- Previous tab
nnoremap_u("<leader>tk", ":tabclose<cr>") -- Close tab
nnoremap_u("<leader>tj", ":tabedit %<cr>") -- Open window new tab
nnoremap_u("<leader>tt", ":tabedit <cr>") -- Open new tab
-- =============================================


-- Nvim-lspconfig mappings
-- =============================================
nnoremap_u("<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
nnoremap_u("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
nnoremap_u("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
nnoremap_u("<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

-- Buffer bindings for after the language server attaches
local on_lsp_server_attach = function(client, bufnr)
  -- Uncomment to enable omnifunc completion.
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_nnoremap_u(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  buf_nnoremap_u(bufnr, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  buf_nnoremap_u(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  buf_nnoremap_u(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  buf_nnoremap_u(bufnr, "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  buf_nnoremap_u(bufnr, "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
  buf_nnoremap_u(bufnr, "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
  buf_nnoremap_u(bufnr, "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
  buf_nnoremap_u(bufnr, "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  buf_nnoremap_u(bufnr, "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  buf_nnoremap_u(bufnr, "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  buf_nnoremap_u(bufnr, "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  buf_nnoremap_nu(bufnr, "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
end


-- TODO: Figure out how to move the setup call to settings.lua

-- Setup Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- Add additional capabilities supported by nvim-cmp
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

local servers = { 'pyright', 'lua_ls', 'cmake', 'clangd', 'yamlls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_lsp_server_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end

-- Black formatter augroup
-- TODO: Figure out how to use the same <space>f format binding here.
local black_fmt_augroup = vim.api.nvim_create_augroup('black_fmt_augroup', {clear = true})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "python",
  group = black_fmt_augroup,
  callback = function()
    nnoremap_nu("<space>z", ":Black<cr>")
  end
})

-- Isort mapping.
vim.g["vim_isort_map"] = ""
local isort_fmt_augroup = vim.api.nvim_create_augroup('isort_fmt_augroup', {clear = true})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "python",
  group = isort_fmt_augroup,
  callback = function()
    nnoremap_nu("<space>i", ":Isort<cr>")
  end
})

-- =============================================


-- Nvim-tree mappings
-- =============================================
nnoremap_u("<leader>nt", ":NvimTreeToggle<cr>")
nnoremap_u("<leader>nr", ":NvimTreeRefresh<cr>") -- Refresh tree
nnoremap_u("<leader>nf", ":NvimTreeFocus<cr>") -- Transfer focus to the tree
nnoremap_u("<leader>nF", ":NvimTreeFindFile<cr>")
-- =============================================


-- Telescope mappings
-- =============================================
nnoremap_u("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nnoremap_u("<leader>fs", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
nnoremap_u("<leader>fl", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nnoremap_u("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nnoremap_u("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
nnoremap_u("<leader>fo", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
nnoremap_u("<leader>fc", "<cmd>lua require('telescope.builtin').command_history()<cr>")
nnoremap_u("<leader>fgs", "<cmd>lua require('telescope.builtin').git_status()<cr>")
-- =============================================

