return {
  'romgrk/barbar.nvim',
  version = '^1.0.0', -- Only update for 1.x releases
  dependencies = {
    'lewis6991/gitsigns.nvim',     -- Optional: for git status
    'nvim-tree/nvim-web-devicons', -- Optional: for file icons
  },
  opts = {
    animation = false,
    tabpages = true,
    focus_on_close = 'left',
    hide = {
      extensions = false,
      inactive = false
    },
    icons = {
      buffer_index = false,
      buffer_number = false,
      button = '',
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
      },
      gitsigns = {
        added = { enabled = true, icon = ' ' },
        changed = { enabled = true, icon = ' ' },
        deleted = { enabled = true, icon = ' ' },
      },
      separator = { left = '▎', right = '' },
      separator_at_end = true,
      modified = { button = '●' },
      pinned = { button = '', filename = true },
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = true },
      inactive = { button = '×' },
      visible = { modified = { buffer_number = false } },
    },
    sidebar_filetypes = {
      NvimTree = true,
      undotree = {
        text = 'undotree',
        align = 'left',
      },
      ['neo-tree'] = { event = 'BufWipeout' },
      Outline = {
        event = 'BufWinLeave',
        text = 'symbols-outline',
        align = 'right'
      },
    },
    maximum_length = 25,
  },
  config = function(_, opts)
    require('barbar').setup(opts)
  end,
}
