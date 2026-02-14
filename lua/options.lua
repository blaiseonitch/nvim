vim.g.mapleader = " "
local options = {
  splitbelow = true,
  splitright = true,
  expandtab = true,
  virtualedit = "block",
  inccommand = "split",
  laststatus = 3,
	ruler = false,            --disable extra numbering
	showmode = true,         --not needed due to lualine
	showcmd = false,
	wrap = true,              --toggle bound to leader W
	mouse = "a",              --enable mouse
	clipboard = "unnamedplus", --system clipboard integration
	history = 100,            --command line history
	swapfile = false,
	backup = false,
	undofile = true,      --undos are saved to file
	cursorline = false,   --highlight line
	ttyfast = true,       --faster scrolling
	smoothscroll = true,
	title = true,         --automatic window titlebar
	shiftwidth = 2,
	number = false,       --numbering lines
	relativenumber = true, --toggle bound to leader nn
	numberwidth = 4,

	smarttab = true, --indentation stuff
	cindent = true,
	autoindent = true,
	tabstop = 2, --visual width of tab

	foldmethod = "expr",
	-- foldlevel = 99, --disable folding, lower #s enable
	foldexpr = "nvim_treesitter#foldexpr()",

	termguicolors = true,

	ignorecase = true,        --ignore case while searching
	smartcase = true,         --but do not ignore if caps are used

	conceallevel = 2,         --markdown conceal
	concealcursor = "nc",
	mousemoveevent = false,   -- block mouse movements
	splitkeep = 'screen',     --stablizie window open/close
	fillchars = { eob = " " }, -- Hide ~ character from buffer lines
}

for k, v in pairs(options) do
	vim.opt[k] = v
end


vim.diagnostic.config({
	signs = false,
	virtual_text = true, -- Show errors in code
	underline = false,  -- underline on error lines
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- restore cursor pos on file open
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 1 and line <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})
