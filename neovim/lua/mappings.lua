function map(mode, shortcut, command, noremap)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = noremap, silent = true, unique=true })
end

function buf_map(bufnr, mode, shortcut, command, noremap)
  vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, command, { noremap = noremap, silent = true, unique=false })
end

function nmap(shortcut, command)
  map('n', shortcut, command, false)
end

function nnoremap(shortcut, command)
  map('n', shortcut, command, true)
end

function imap(shortcut, command)
  map('i', shortcut, command, false)
end

function inoremap(shortcut, command)
  map('i', shortcut, command, true)
end

function vmap(shortcut, command)
  map('v', shortcut, command, false)
end

function vnoremapmap(shortcut, command)
  map('v', shortcut, command, true)
end

function buf_nnoremap(bufnr, shortcut, command)
  buf_map(bufnr, 'n', shortcut, command, true)
end

-- Save and close mappings
-- =============================================
nnoremap("<leader>w", ":w<cr>")
nnoremap("<leader>q", ":q<cr>")
-- =============================================


-- Scroll mappings
-- =============================================
nnoremap("<leader>md", "25<c-e>") -- Scroll down 25 lines
nnoremap("<leader>me", "25<c-y>") -- Scroll up 25 lines
-- =============================================


-- Newline mappings
-- =============================================
nnoremap("<leader>no", "o<Esc>") -- Insert a line below and go to normal mode
nnoremap("<leader>nO", "O<Esc>") -- Insert a line above and go to normal mode
-- =============================================


-- Buffer mappings
-- =============================================
nnoremap("<leader>bl", ":bnext<cr>") -- Next buffer
nnoremap("<leader>bh", ":bprevious<cr>") -- Previous buffer
nnoremap("<leader>bk", ":bdelete<cr>") -- close buffer
-- =============================================



-- Window mappings
-- =============================================
nnoremap("<leader>sh", "<c-w>h")
nnoremap("<leader>sl", "<c-w>l")
nnoremap("<leader>sj", "<c-w>j")
nnoremap("<leader>sk", "<c-w>k")
-- =============================================


-- Tab mappings
-- =============================================
nnoremap("<leader>tl", ":tabn<cr>") -- Next tab
nnoremap("<leader>th", ":tabp<cr>") -- Previous tab
nnoremap("<leader>tk", ":tabclose<cr>") -- Close tab
nnoremap("<leader>tj", ":tabedit %<cr>") -- Open window new tab
nnoremap("<leader>tt", ":tabedit <cr>") -- Open new tab
-- =============================================


-- Nvim-lspconfig mappings
-- =============================================
nnoremap('<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
nnoremap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nnoremap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nnoremap('<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

-- Buffer bindings for after the language server attaches
local on_attach = function(client, bufnr)
  -- Uncomment to enable omnifunc completion.
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_nnoremap(bufnr, 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_nnoremap(bufnr, 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_nnoremap(bufnr, 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_nnoremap(bufnr, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_nnoremap(bufnr, '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_nnoremap(bufnr, '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  buf_nnoremap(bufnr, '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  buf_nnoremap(bufnr, '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  buf_nnoremap(bufnr, '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_nnoremap(bufnr, '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_nnoremap(bufnr, '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_nnoremap(bufnr, 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_nnoremap(bufnr, '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end


-- TODO: Figure out how to move the setup call to settings.lua

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local lspconfig = require('lspconfig')

local servers = { 'pyright', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end
-- =============================================


-- Nvim-tree mappings
-- =============================================
nnoremap("<leader>nt", ":NvimTreeToggle<cr>")
nnoremap("<leader>nr", ":NvimTreeRefresh<cr>") -- Refresh tree
nnoremap("<leader>nf", ":NvimTreeFocus<cr>") -- Transfer focus to the tree
nnoremap("<leader>nF", ":NvimTreeFindFile<cr>")
-- =============================================

