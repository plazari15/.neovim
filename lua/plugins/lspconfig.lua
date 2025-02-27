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
          'goimports',
          'gofumpt',
          'gomodifytags',
          'impl',
          'delve'
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
          -- -- Copilot Source --
          -- { name = 'copilot', group_index = 2},

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
      "L3MON4D3/LuaSnip",
      'hrsh7th/cmp-nvim-lsp',
      'kristijanhusak/vim-dadbod-completion',
      'zbirenbaum/copilot-cmp',
      
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
        table.insert(opts.sources, 1, {
          name = "copilot",
          group_index = 1,
          priority = 100,
        })
        -- vim.list_extend(opts.sources, {
        --   name = "copilot",
        --   group_index = 1,
        --   priority = 100,
        -- })
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
    setup = {
      eslint = function()
        if not auto_format then
          return
        end
  
        local function get_client(buf)
          return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
        end
  
        local formatter = LazyVim.lsp.formatter({
          name = "eslint: lsp",
          primary = false,
          priority = 200,
          filter = "eslint",
        })
  
        -- Use EslintFixAll on Neovim < 0.10.0
        if not pcall(require, "vim.lsp._dynamic") then
          formatter.name = "eslint: EslintFixAll"
          formatter.sources = function(buf)
            local client = get_client(buf)
            return client and { "eslint" } or {}
          end
          formatter.format = function(buf)
            local client = get_client(buf)
            if client then
              local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
              if #diag > 0 then
                vim.cmd("EslintFixAll")
              end
            end
          end
        end
  
        -- register the formatter with LazyVim
        LazyVim.format.register(formatter)
      end,

      gopls = function(_, opts)
        -- workaround for gopls not supporting semanticTokensProvider
        -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        LazyVim.lsp.on_attach(function(client, _)
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end
        end, "gopls")
        -- end workaround
      end,
    },
  }
}
