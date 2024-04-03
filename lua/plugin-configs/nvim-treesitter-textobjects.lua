-- 1. @assignment.inner
-- 2. @assignment.lhs
-- 3. @assignment.outer
-- 4. @assignment.rhs

require('nvim-treesitter.configs').setup {
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
}

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, "<BS>", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

local utils = require('utils')
utils.setup_au_reload_command()
utils.print_filename_on_reload()
