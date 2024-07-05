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

-- Load nvim settings
-- =============================================
nnoremap_u("<leader>sv", ":source $MYVIMRC<CR>")
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


-- Setting mappings
-- =============================================
nnoremap_nu("<Esc>", "<cmd>nohlsearch<CR>")
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


-- Colorscheme setup
-- Ideally this is done post install, but keeping it here for now.
-- =============================================
vim.cmd([[
  let g:sonokai_style = 'andromeda'
  let g:sonokai_better_performance = 1
  colorscheme sonokai
]])
-- =============================================
