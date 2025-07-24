local K = vim.keymap.set
local opts = {noremap = true, silent = true }

vim.g.mapleader = " "  -- set space as leader key
vim.g.maplocalleader = " "

-- NORMAL MODE
-- Better windows navigation
K("n", "<C-h>", "<C-w>h", opts) -- crtl + h to move to window left 
K("n", "<C-j>", "<C-w>j", opts) -- crtl + j to move to window up
K("n", "<C-k>", "<C-w>k", opts) -- crtl + k to move to window below
K("n", "<C-l>", "<C-w>l", opts) -- crtl + l to move to window right 

-- Resize buffer with arrows
K("n", "<C-Up>", ":resize -2<CR>", opts)
K("n", "<C-Down>", ":resize +2<CR>", opts)
K("n", "<C-Left>", ":vertical resize -2<CR>", opts)
K("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ZZ to save and exit
-- ZQ exit without saving

-- shortcuts
K("n", "<leader>w", ":w<CR>", opts) -- space(leader) + w to save file 
K("n", "<leader>q", ":q<CR>", opts) -- space + q to exit 
K("n", "<leader>h", ":nohlsearch<CR>", opts) -- space + c to clear highlights

-- INSERT MODE 
K("i", "jj", "<Esc>", opts) -- exit insert mode with jj


-- PLUGIN MAPS

-- Telescope 
K("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
K("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)

-- Nvim Tree
K("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)
