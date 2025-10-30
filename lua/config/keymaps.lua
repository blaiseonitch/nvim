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

-- NORMAL Modes

-- Better windows navigation
K("n", "<C-h>", "<C-w>h", opts) -- crtl + h to move to window left
K("n", "<C-j>", "<C-w>j", opts) -- crtl + j to move to window up
K("n", "<C-k>", "<C-w>k", opts) -- crtl + k to move to window below
K("n", "<C-l>", "<C-w>l", opts) -- crtl + l to move to window right

-- Move to previous/next
K("n", "<leader>fb", "<Cmd>bnext<CR>", opts)

-- Splitting screen
K("n", "<leader>s", ":split<CR>:bnext<CR>", opts)   -- split screen horizontally
K("n", "<leader>vs", ":vsplit<CR>:bnext<CR>", opts) -- split screen vertically

-- Resize buffer with arrows
K("n", "<C-Up>", ":resize -2<CR>", opts)             -- resize current active buffer 2 pixels to the top
K("n", "<C-Down>", ":resize +2<CR>", opts)           -- resize current active buffer 2 pixels to the bottom
K("n", "<C-Left>", ":vertical resize -2<CR>", opts)  -- resize current active buffer 2 pixels to the left
K("n", "<C-Right>", ":vertical resize +2<CR>", opts) -- resize current active buffer 2 pixels to the right

-- Create and move across tabs
--K("n", "<leader>tn" ":tabedit <C-r>=escape(expand("%:p:h"), " ")<CR>/", opts)
K("n", "<leader>tn", ":tabnew<CR>", opts)
K("n", "<leader>tc", ":tabclose<CR>", opts)
K("n", "<leader>tN", ":tabNext<CR>", opts)

-- ZZ to save and exit
-- ZQ exit without saving

-- shortcuts
K("n", "<leader>w", ":w<CR>", opts)          -- space(leader) + w to save file
K("n", "<leader>q", ":q<CR>", opts)          -- space + q to exit
K("n", "<leader>h", ":nohlsearch<CR>", opts) -- space + h to clear highlights

-- INSERT MODE
K("i", "jj", "<Esc>", opts)             -- exit insert mode with jj
K("i", "JJ", "<Esc>", opts)             -- exit insert mode with JJ

K("v", "<", "<gv", opts)                -- stay in visual mode when manually indenting
K("v", ">", ">gv", opts)                -- stay in // // // // //

K("v", "<A-j>", ":m .+1<CR>==gv", opts) -- move highlighted text down
K("v", "<A-k>", ":m .-2<CR>==gv", opts) -- move highlighted text up
K("v", "p", '"_dP', opts)

-- TERMINAL MODE
K('t', 'jj', [[<C-\><C-n>]], {}) --leave terminal mode
K('t', '<Esc>', '<Esc>', { noremap = true, silent = true })

-- PLUGIN MAPS
-- Nvim Tree
K("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts) -- Toggle file explorer

-- Zen Mode
K("n", "<leader>zz", "<cmd>ZenMode<cr>", opts) -- Toggle zen mode

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


-- K("n", "<leader>fm", function()
-- 	vim.lsp.buf.format({ async = true })
-- end, { buffer = bufnr, desc = "Format file" })

K("n", "<leader>fm", "=G", opts)

K("n", "<leader>d", function() -- Display diagnostics (if any errors)
	vim.diagnostic.open_float({
		border = "rounded",
	})
end, opts)

-- Track state outside
local diagnostics_virtual_text = true

K("n", "<leader>mm", function()
  diagnostics_virtual_text = not diagnostics_virtual_text
  vim.diagnostic.config({
    virtual_text = diagnostics_virtual_text,
  })
end, opts)

K("n", "<leader>k", vim.lsp.buf.hover, opts)          -- Display function/class documentory
K("n", "<leader>gd", vim.lsp.buf.definition, opts)              -- Go to definition of highlighted o,bject
K({ "n", "i" }, "<leader>gs", vim.lsp.buf.signature_help, opts) -- Display the information parameters of current funtion
K({"n", "i"}, "<leader>gf", vim.lsp.buf.declaration, opts)             -- Go to declaration of highlighted object

-- MISC
K("n", "<leader>R", ":so %<CR>", opts) -- Reload nvim config
K("i", "<C-BS>", "<C-w>", opts)        --VSCODE like per word deletion
K("i", "<C-Del>", "<C-o>dw", opt)
-- K("n", "<leader>fd", "za", opts) -- toggle code fold for current code block
--
-- K("n", "<leader>fa", function ()
-- 	local foldLevel = vim.fn.foldlevel(".")
-- 	if foldLevel > 0 and vim.fn.foldclosed(".") == -1 then
-- 		vim.cmd("normal! zM") -- close all.
-- 	else
-- 		vim.cmd("normal! zR") -- open all.
-- 	end
-- end, opts )

K('n', '<leader>sp', '<cmd>set spell!<CR>', { desc = "Toggle spell checker" })

--Disabled keys
K({ 'i', 'n', 'v' }, '<PageUp>', '<Nop>', { silent = true })
K({ 'i', 'n', 'v' }, '<PageDown>', '<Nop>', { silent = true })


