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


K("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, { buffer = bufnr, desc = "Format file" })

-- K("n", "<leader>fm", "=G", opts)

K("n", "<leader>d", function() -- Display diagnostics (if any errors)
  vim.diagnostic.open_float({
    border = "rounded",
  })
end, opts)

-- Track state outside
local diagnostics_virtual_lines = true

K("n", "<leader>mm", function()
  diagnostics_virtual_lines = not diagnostics_virtual_lines
  vim.diagnostic.config({
    virtual_lines = diagnostics_virtual_lines,
  })
end, { desc = "toggle diagnostics_virtual_lines" })

K("n", "<leader>k", function()
  vim.lsp.buf.hover()
end, { desc = "Display function/class 'documentory'" })
K("n", "<leader>gd", function()
  vim.lsp.buf.definition()
end, { desc = "Go to definition of highlighted object" })
K({ "n", "i" }, "<leader>gs", function()
  vim.lsp.buf.signature_help()
end, { desc = "Display the information parameters of current funtion" })
K({ "n", "i" }, "<leader>gf", function()
  vim.lsp.buf.declaration()
end, { desc = "Go to declaration of highlighted object" })

K("n", "nt", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

K("n", "pt", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

K("n", "<leader>tgg", "<cmd>TodoFzfLua<cr>", opts) -- Open todo-comment exploer
-- end,
-- {desc="Open todo-comment exploer"})
--
K("n", "<leader>qff", "<cmd>TodoQuickFix<cr>", opts) -- Open todo-quickfix exploer
-- MISC
K("n", "<leader>R", ":so %<CR>", opts) -- Reload nvim config
K("i", "<C-BS>", "<C-w>", opts)        --VSCODE like per word deletion
K("i", "<C-Del>", "<C-o>dw", opts)

-- K("n", "<leader>fd", "za", opts) -- toggle code fold for current code block

K('n', '<leader>sp', '<cmd>set spell!<CR>', { desc = "Toggle spell checker" })

--Disabled keys
K({ 'i', 'n', 'v' }, '<PageUp>', '<Nop>', { silent = true })
K({ 'i', 'n', 'v' }, '<PageDown>', '<Nop>', { silent = true })
