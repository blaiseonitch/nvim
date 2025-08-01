local K = vim.keymap.set
local opts = { noremap = true, silent = true }
local fzf = require("fzf-lua")

-- Find project root (parent directory containing .git)
local function get_project_root()
	local root = vim.fs.dirname(vim.fs.find('.git', { upward = true })[1])
	return root or vim.loop.cwd()
end

--[ Modes
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- term_mode = "t",
-- visual_block_mode = "x",
-- command_mode = "c",
--]

-- NORMAL MODE

-- Better windows navigation
K("n", "<C-h>", "<C-w>h", opts) -- crtl + h to move to window left
K("n", "<C-j>", "<C-w>j", opts) -- crtl + j to move to window up
K("n", "<C-k>", "<C-w>k", opts) -- crtl + k to move to window below
K("n", "<C-l>", "<C-w>l", opts) -- crtl + l to move to window right

-- Move to previous/next
K("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
K("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

-- Quick buffer switching (Alt+1-9)
K("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
K("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
K("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
K("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
K("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
K("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
K("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
K("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
K("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
K("n", "<A-0>", "<Cmd>BufferLast<CR>", opts) -- Last buffer

-- Quick close/pin
K("n", "<A-c>", "<Cmd>BufferClose<CR>", opts) -- Close current buffer
K("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)   -- Pin/unpin buffer

-- Splitting screen
K("n", "<leader>s", ":split<CR>:bnext<CR>", opts)   -- split screen horizontally
K("n", "<leader>vs", ":vsplit<CR>:bnext<CR>", opts) -- split screen vertically

-- Resize buffer with arrows
K("n", "<C-Up>", ":resize -2<CR>", opts)             -- resize current active buffer 2 pixels to the top
K("n", "<C-Down>", ":resize +2<CR>", opts)           -- resize current active buffer 2 pixels to the bottom
K("n", "<C-Left>", ":vertical resize -2<CR>", opts)  -- resize current active buffer 2 pixels to the left
K("n", "<C-Right>", ":vertical resize +2<CR>", opts) -- resize current active buffer 2 pixels to the right

-- ZZ to save and exit
-- ZQ exit without saving

-- shortcuts
K("n", "<leader>w", ":w<CR>", opts)          -- space(leader) + w to save file
K("n", "<leader>q", ":q<CR>", opts)          -- space + q to exit
K("n", "<leader>h", ":nohlsearch<CR>", opts) -- space + h to clear highlights

-- INSERT MODE
K("i", "jj", "<Esc>", opts)           -- exit insert mode with jj
K("i", "JJ", "<Esc>", opts)           -- exit insert mode with JJ

K("v", "<", "<gv", opts)              -- stay in visual mode when manually indenting
K("v", ">", ">gv", opts)              -- stay in // // // // //

K("v", "<A-j>", ":m .+1<CR>==", opts) -- move highlighted text down
K("v", "<A-k>", ":m .-2<CR>==", opts) -- move highlighted text up
K("v", "p", '"_dP', opts)

-- TERMINAL MODE
K('n', '<leader>`', ':ToggleTerm size=5 direction=horizontal<CR>', { desc = "Open Bottom Terminal", silent = true }) --toggle terminal
K('t', 'jj', [[<C-\><C-n>]], {})                                                                                     --leave terminal mode
K('t', '<Esc>', '<Esc>', { noremap = true, silent = true })

-- PLUGIN MAPS
-- Nvim Tree
K("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts) -- Toggle file explorer

-- FZF-LUA Mappings (ALL use project root)
K("n", "<leader>ff", function()
	fzf.files({ cwd = get_project_root() }) -- Files in project root
end, { desc = "Files (Project)" })

K("n", "<leader>gg", function()
	fzf.live_grep({ cwd = get_project_root() }) -- Grep in project root
end, { desc = "Words (Project)" })

K("n", "<leader>fu", function()
	fzf.grep({
		search = vim.fn.expand('<cword>'),
		cwd = get_project_root() -- Search word under cursor in project root
	})
end, { desc = "Word under cursor (Project)" })

-- MISC
K("n", "<leader>R", ":so %<CR>", opts) -- Reload nvim config
