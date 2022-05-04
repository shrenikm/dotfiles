function map(mode, shortcut, command, noremap)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = noremap, silent = true, unique=true})
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

-- Save
nnoremap("<leader>w", ":w<cr>")

-- Close
nnoremap("<leader>q", ":q<cr>")



-- Scroll down 25 lines
nnoremap("<leader>md", "25<c-e>")

-- Scroll up 25 lines
nnoremap("<leader>me", "25<c-y>")



-- Insert a line below and go to normal mode
nnoremap("<leader>no", "o<Esc>")

-- Insert a line above and go to normal mode
nnoremap("<leader>nO", "O<Esc>")



-- Next buffer
nnoremap("<leader>bl", ":bnext<cr>")

-- Previous buffer
nnoremap("<leader>bh", ":bprevious<cr>")

-- Close buffer
nnoremap("<leader>bk", ":bdelete<cr>")



-- Switch windows
nnoremap("<leader>sh", "<c-w>h")
nnoremap("<leader>sl", "<c-w>l")
nnoremap("<leader>sj", "<c-w>j")
nnoremap("<leader>sk", "<c-w>k")


-- Next tab
nnoremap("<leader>tl", ":tabn<cr>")

-- Previous tab
nnoremap("<leader>th", ":tabp<cr>")

-- Close tab
nnoremap("<leader>tk", ":tabclose<cr>")

-- Open window new tab
nnoremap("<leader>tj", ":tabedit %<cr>")

-- Open new tab
nnoremap("<leader>tt", ":tabedit <cr>")



-- Nvim-tree mappings
nnoremap("<leader>nt", ":NvimTreeToggle<cr>")
nnoremap("<leader>nr", ":NvimTreeRefresh<cr>")
nnoremap("<leader>nf", ":NvimTreeFocus<cr>")
nnoremap("<leader>nF", ":NvimTreeFindFile<cr>")

