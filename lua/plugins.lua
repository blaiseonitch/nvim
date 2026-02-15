-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- COLOR THEMES
require("lazy").setup({
  {
    "rebelot/kanagawa.nvim",
    config = function()
      -- vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
  {
    'aikhe/fleur.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme fleur")
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Default options:
      require("gruvbox").setup({
        palette_overrides = {
          dark0_hard = "#000000",
        }
      })
      vim.cmd("colorscheme gruvbox")
    end
  },
  {
    "askfiy/visual_studio_code",
    priority = 100,
    config = function()
      require("visual_studio_code").setup({
        mode = "dark",
        -- Whether to load all color schemes
        preset = true,
        -- Whether to enable background transparency
        transparent = true,
        expands = {
          hop = true,
          dbui = true,
          lazy = true,
          aerial = true,
          null_ls = true,
          nvim_cmp = true,
          gitsigns = true,
          which_key = true,
          nvim_tree = false,
          lspconfig = true,
          telescope = true,
          bufferline = true,
          nvim_navic = true,
          nvim_notify = true,
          vim_illuminate = true,
          nvim_treesitter = true,
          nvim_ts_rainbow = true,
          nvim_scrollview = true,
          nvim_ts_rainbow2 = true,
          indent_blankline = true,
          vim_visual_multi = true,
        },
        hooks = {
          before = function(conf, colors, utils) end,
          after = function(conf, colors, utils) end,
        },
      })
      -- vim.cmd([[colorscheme visual_studio_code]])
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = 'main',
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'v',
            ['@class.outer'] = '<c-v>',
          },
          include_surrounding_whitespace = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select").select_textobject
      vim.keymap.set({ "x", "o" }, "af", function()
        select("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        select("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        select("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        select("@class.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "as", function()
        select("@local.scope", "locals")
      end)
    end,
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    config = function()
      require("treesitter-modules").setup({
        ensure_installed = {
          "lua",
          "python",
          "javascript",
          "html",
          "css",
          "bash",
          "markdown",
          "json",
          "c",
          "cpp",
          "c_sharp",
          "java",
          "cmake",
          "make",
          "yaml",
          "gdscript",
          "rust",
          "query",
          "vim",
        },
        auto_install = true,
        highlight = {
          enable = true,
        },

        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>ss",
            node_incremental = "<leader>si",
            scope_incremental = "<leader>sc",
            node_decremental = "<leader>sd",
          },
        },
      })
    end
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 5
          elseif term.direction == "vertical" then
            return 5
          end
          -- elseif term.direction == "vertical" then
          -- return math.floor(vim.o.columns * 0.5)
          -- end
        end,
        open_mapping = false,
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
      })

      -- keep track of terminal count for splitting
      local terminal_count = 0

      -- function to create/toggle terminals with splitting behavior
      function _G.smart_toggle_term(direction, size)
        direction = direction or "horizontal"
        size = size or (direction == "horizontal" and 5 or 5)

        -- check if we're currently in a terminal
        if vim.bo.buftype == "terminal" then
          -- we're in a terminal, create a new one (this will split)
          terminal_count = terminal_count + 1
          vim.cmd(string.format("ToggleTerm %d size=%d direction=%s", terminal_count, size, direction))
        else
          -- Not in terminal, check if any terminal is open
          local term_wins = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
              table.insert(term_wins, win)
            end
          end

          if #term_wins > 0 then
            -- Terminal exists, create new one (will split)
            terminal_count = terminal_count + 1
            vim.cmd(string.format("ToggleTerm %d size=%d direction=%s", terminal_count, size, direction))
          else
            -- No terminal open, create first one
            terminal_count = 1
            vim.cmd(string.format("ToggleTerm %d size=%d direction=%s", terminal_count, size, direction))
          end
        end
      end
    end,
    keys = {
      -- Smart toggle (creates new if in terminal, toggles if not)
      { "<A-h>",      "<cmd>lua smart_toggle_term('horizontal', 5)<cr>", desc = "Smart Horizontal Terminal" },
      { "<A-v>",      "<cmd>lua smart_toggle_term('vertical', 25)<cr>",  desc = "Smart Vertical Terminal" },
      { "<A-f>",      "<cmd>lua smart_toggle_term('float')<cr>",         desc = "Smart Float Terminal" },

      -- Toggle specific terminals
      { "<leader>t1", "<cmd>1ToggleTerm<cr>",                            desc = "Toggle Terminal 1" },
      { "<leader>t2", "<cmd>2ToggleTerm<cr>",                            desc = "Toggle Terminal 2" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = false,
              git = false,
            },
          },
        },
        view = {
          width = 20,
          side = 'left',
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
          update_root = true,
        },
      }
    end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    config = function()
      require("fzf-lua").setup({

      })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional icon support
    event = "VeryLazy",                               -- Loads after UI starts (better performance)
    opts = function()
      -- local diagnostics = {
      -- 	"diagnostics",
      -- 	sources = { "nvim_diagnostic" },
      -- 	sections = { "error", "warn" },
      -- 	symbols = { error = " ", warn = " " },
      -- 	colored = true,
      -- 	update_in_insert = false,
      -- 	always_visible = true,
      -- 	cond = function()
      -- 		return vim.bo.filetype ~= "markdown"
      -- 	end,
      -- }

      local progress = function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local line_ratio = current_line / total_lines
        return math.floor(line_ratio * 100) .. "%%"
      end

      return {
        options = {
          icons_enabled = true,
          -- theme = "tomorrow_night",
          -- theme = "16color",
          -- theme = "base16",
          component_separators = "",
          -- section_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          section_separators = "",
          disabled_filetypes = {
            "alpha",
            "dashboard",
            "NvimTree",
            "toggleterm",
          },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { { "branch", icon = "" } },
          lualine_b = { "mode" },
          -- lualine_c = { diagnostics },
          lualine_c = { { "filename", path = 0, file_status = true } },
          lualine_x = {
            -- { "diff",
            --   colored = true,
            --   symbols = { added = " ", modified = " ", removed = " " }
            -- },
            "fileformat",
            "filetype",
            "encoding"
          },
          lualine_y = { progress },
          -- lualine_z = { "location" },
          lualine_z = {
            "location"
            -- function()
            -- 	return string.format("%d|%d", vim.fn.line("."), vim.fn.line("$"))
            -- end
          }
        },
        extensions = { "nvim-tree" },
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
      -- Optional transparency fix (works better than per-component overrides)
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
    end
  },
  {
    "norcalli/nvim-colorizer.lua", -- Note: Correct repo is "norcalli/nvim-colorizer.lua"
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features
        css_fn = true, -- Enable all CSS *functions*
        -- Additional options:
        mode = "background", -- Set display mode (foreground/background)
        virtualtext = "■", -- Show color preview in virtualtext
      })
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      keymap = {
        ["<CR>"] = { "accept", "fallback" }, -- Enter confirms suggestion
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "hide", "fallback" }, -- Escape
      },

      appearance = {
        nerd_font_variant = "mono",
      },
      completion = { documentation = { auto_show = true } },

      sources = {
        -- default = { 'lsp', 'path', 'snippets', 'buffer' },
        default = { "lazydev", "lsp", "path", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        registries = {
          'github:Crashdummyy/mason-registry',
          'github:mason-org/mason-registry',
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "lua_ls",
          "pyright",
          "marksman",
          "ts_ls",
          "cmake",
          "html",
          "cssls",
          "jdtls",
          "eslint",
          "glsl_analyzer",
          "rust_analyzer",
          "ts_ls"
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()

    end
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function()

    end
  },
  {

    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = vim.lsp.config

      -- Lua LSP Setup
      lspconfig("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- VCPKG  setup
      local function get_vcpkg_includes()
        local vcpkg_root = os.getenv("VCPKG_ROOT") or os.getenv("HOME") .. "/vcpkg"
        local triplet = os.getenv("VCPKG_DEFAULT_TRIPLET") or "x64-linux"
        return {
          "-I" .. vcpkg_root .. "/installed/" .. triplet .. "/include",
        }
      end

      -- C/C++ LSP Setup
      lspconfig("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--enable-config",
        },
        init_options = {
          fallbackFlags = get_vcpkg_includes(),
        },
        capabilities = capabilities,
        on_attach = function(client, bufnr) end,
      })

      -- Python LSP Setup
      lspconfig("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            pythonPath = vim.fn.exepath("python3"),
          },
        },
      })

      lspconfig("roslyn", {
        on_attach = function()
          print("roslyn lsp attached")
        end,
        { capabilities = capabilities },
        settings = {
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = false,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      })

      lspconfig("emmet_ls", {
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
              ["jsx.enabled"] = true,
            },
          },
        },
      })

      lspconfig("jsonls", { capabilities = capabilities })
      lspconfig("eslint", { capabilities = capabilities })
      lspconfig("marksman", { capabilities = capabilities })
      lspconfig("ts_ls", { capabilities = capabilities })
      lspconfig("cmake", { capabilities = capabilities })
      lspconfig("html", { capabilities = capabilities })
      lspconfig("cssls", { capabilities = capabilities })
      lspconfig("glsl_analyzer", { capabilities = capabilities })
      lspconfig("rust_analyzer", { capabilities = capabilities })
      lspconfig("asm_lsp", { capabilities = capabilities })
    end
  },
  -- Not needed right now, causes double code suggestion
  -- {
  --   "seblyng/roslyn.nvim",
  --   ft = { "cs" },
  --   opts = {
  --     -- your configuration comes here; leave empty for default settings
  --     silent = false,
  --   },
  -- },
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
        main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
        client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
        log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number  = false,                      -- Displays the current line number instead of the current project
        blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time           = true,                       -- Show the timer

        -- Rich Presence text options
        editing_text        = "Editing %s",         -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text  = "Browsing %s",        -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins",   -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text        = "Reading %s",         -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text      = "Working on %s",      -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text    = "Line %s out of %s",  -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      })
    end
  },
  {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua        = { "stylua" },
          python     = { "black" },
          rust       = { "rustfmt", lsp_format = "fallback" },
          javascript = { "prettier", stop_after_first = true },
          c          = { "clang_format" },
          cpp        = { "clang_format" },
        },
      })
    end
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" }, -- Lazy-load on file open
    config = function()
      require("lint").linters_by_ft = {
        python = { "flake8", "pylint" },
        javascript = { "eslint_d" },
        sh = { "shellcheck" },
        -- Add more filetypes as needed
      }

      -- Auto-trigger linting on save
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },
  {
    "folke/twilight.nvim",
    keys = { -- Lazy-load only when the key is pressed
      { "<leader>l", "<cmd>Twilight<cr>", desc = "Toggle Twilight (focus mode)" },
    },
    opts = {
      -- Default configuration
      dimming = {
        alpha = 0.25,                    -- Amount of dimming (0-1 where 1 is fully opaque)
        color = { "Normal", "#ffffff" }, -- Dimming color
        term_bg = "#000000",             -- Terminal background for dimming
        inactive = false,                -- Dim inactive windows
      },
      context = 25,                      -- Number of lines to keep above/below visible
      treesitter = true,                 -- Use treesitter when available
      expand = {                         -- Filetypes where Twilight expands
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {}, -- exclude these filetypes
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95,          -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 120,              -- width of the Zen window
        height = 1,               -- height of the Zen window
        options = {
          relativenumber = false, -- disable relative numbers
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        todo = { enabled = false },
        kitty = {
          enabled = false,
          font = "+4",
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
        print("Zen Mode Activated")
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        print("Zen Mode Deactivated")
      end,
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,                         -- sign priority
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",         -- The gui style to use for the fg highlight group.
        bg = "BOLD",         -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true,                -- enable multine todo comments
        multiline_pattern = "^.",        -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
        before = "",                     -- "fg" or "bg" or empty
        keyword = "wide",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",                    -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true,            -- uses treesitter to match keywords in comments only
        max_line_len = 400,              -- ignore lines longer than this
        exclude = {},                    -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    }
  },
})
