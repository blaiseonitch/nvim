vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.o.showmode = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 2       -- How many spaces a tab counts for
vim.opt.shiftwidth = 2    -- Size of an indent (>>, <<, auto-indent)
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.g.barbar_auto_setup = false -- disable auto-setup

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
