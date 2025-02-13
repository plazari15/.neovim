return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim",
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup {
      }

      vim.keymap.set("n", "<leader>gs", (function()
        return neogit.open()
      end), { noremap = true })
    end
  },
  { 'akinsho/git-conflict.nvim', version = "*", config = true },

  --  inline gitblame and chunk preview
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 100,
          ignore_whitespace = true,
          virt_text_priority = 100,
        }
      }
      vim.keymap.set("n", "<leader>gb", "<cmd>:Gitsigns toggle_current_line_blame<CR>")
      vim.keymap.set("n", "<leader>gd", "<cmd>:Gitsigns preview_hunk<CR><cmd>:Gitsigns preview_hunk<CR>")
    end
  },

  -- githelper to auto generate links to github
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require 'gitlinker'.setup {}

      vim.api.nvim_set_keymap('n', '<leader>gB',
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        { silent = true })
      vim.api.nvim_set_keymap('v', '<leader>gB',
        '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        {})
    end
  },
}
