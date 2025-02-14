return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'clojure_lsp',
          'gopls',
          'lua_ls',
        },
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      "L3MON4D3/LuaSnip",
      'hrsh7th/cmp-nvim-lsp',
      'kristijanhusak/vim-dadbod-completion',
      'zbirenbaum/copilot-cmp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        formatting = {
          format = function(entry, vim_item)
            local source = entry.source.name
            local source_name = ({
              nvim_lsp = 'LSP',
              buffer = 'Buffer',
            })[source] or source

            vim_item.menu = '[' .. source_name .. ']'

            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert {
          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-b>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        sources = cmp.config.sources {
          -- Copilot Source --
          { name = 'copilot', group_index = 2},

          -- Other Sources --
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = "vim-dadbod-completion", max_item_count = 10 },
        },
      }
    end
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "nvim-lua/lsp-status.nvim",
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- ```lua
    -- opts = {
    --   auto_brackets = { "python" }
    -- }
    -- ```
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        vim.list_extend(opts.sources, { name = "clojure" })

        print("Esse opts é de dentro do copilot.lua")
        vim.list_extend(opts.sources, {
          name = "copilot",
          group_index = 1,
          priority = 100,
        })
      end
    end,
    main = "lazyvim.util.cmp",
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      -- vim.list_extend(Keys, {
      --   { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>", desc = "Goto Definition", has = "definition" },
      --   { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>", desc = "References", nowait = true },
      --   { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
      --   { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
      -- })
    end,
  }
}
