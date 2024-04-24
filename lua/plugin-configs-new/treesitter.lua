local ts_langs = {
  'bash',
  'c',
  'css',
  'haskell',
  'html',
  'java',
  'javascript',
  'json',
  'lua',
  'markdown',
  'ocaml',
  'ruby',
  'rust',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    -- the following opts include items specific to treesitter-textobjects
    opts = {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = ts_langs,

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = true,

      -- List of parsers to ignore installing
      ignore_install = {},

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        --disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        --the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aa"] = "@assignment.outer",
            ["ia"] = "@assignment.inner",
            ["ial"] = "@assignment.lhs",
            ["iar"] = "@assignment.rhs",
          },
          selection_modes = {
            ['@function.outer'] = 'V', -- linewise
            ['@function.inner'] = 'V',
            ['@assignment.outer'] = 'v',
            ['@assignment.inner'] = 'v',
            ['@assignment.lhs'] = 'v',
            ['@assignment.rhs'] = 'v',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sp"] = "@parameter.outer",
          },
          swap_previous = {
            ["<leader>sP"] = "@parameter.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]a"] = "@assignment.inner",
            ["]p"] = "@parameter.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]A"] = "@function.inner",
            ["]P"] = "@parameter.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[a"] = "@assignment.inner",
            ["[p"] = "@parameter.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[A"] = "@assignment.inner",
            ["[P"] = "@parameter.outer",
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
          },
          goto_previous = {
          }
        },
      },
    },
    config = function(_, opts)
      require 'nvim-treesitter.configs'.setup(opts)

      -- tree-sitter.textobjects messes with repeating moves; the following fixes it
      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, "<BS>", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
  },
}
