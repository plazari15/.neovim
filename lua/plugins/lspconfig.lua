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
          'templ',
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
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = "vim-dadbod-completion", max_item_count = 10 },
        },
      }
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'nvim-lua/lsp-status.nvim',
    },
    config = function()
      local lsp_status = require('lsp-status')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

      local lspconfig = require('lspconfig')
      lspconfig.clojure_lsp.setup {
        capabilities = capabilities,
        root_dir = function(pattern)
          local util = require("lspconfig.util")
          local fallback = vim.loop.cwd()
          local patterns = { "project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git", "bb.edn" }

          local root = util.root_pattern(patterns)(pattern)
          return (root or fallback)
        end
      }

      lspconfig.dartls.setup {
        capabilities = capabilities,
      }
      lspconfig.gopls.setup {
        cmd = { 'gopls', 'serve' },
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      }

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = {
                [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                [vim.fn.stdpath 'config' .. '/lua'] = true,
              },
            },
          },
        }
      }

      lspconfig.ocamllsp.setup {
        capabilities = capabilities,
      }

      lspconfig.pyright.setup {
        capabilities = capabilities,
      }

      lspconfig.templ.setup {
        capabilities = capabilities,
      }
      vim.filetype.add({ extension = { templ = "templ" } })

      lspconfig.ts_ls.setup {
        capabilities = capabilities
      }

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(event)
          local bufnr = event.buf
          local lsp_client_id = event.data.client_id

          -- Enable completion triggered by <c-x><c-o>
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = bufnr }

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references<CR>', opts)

          local lsp_client = vim.lsp.get_client_by_id(lsp_client_id)
          if not lsp_client then
            return
          end
          local actions = {}
          actions['document.formatting'] = lsp_client.server_capabilities.documentFormattingProvider

          local codeActionsKinds = lsp_client and
              lsp_client.server_capabilities and
              lsp_client.server_capabilities.codeActionProvider and
              lsp_client.server_capabilities.codeActionProvider.codeActionKinds or {}


          -- index actions by key
          for _k, v in pairs(codeActionsKinds) do
            actions[v] = true
          end


          if actions['document.formatting'] then
            -- print('attached formatting buf' .. bufnr .. ' to lsp client ' .. lsp_client_id)

            local format_fn = function()
              lsp_format.format_buffer(bufnr)
            end

            vim.keymap.set('n', '<localleader>fb', format_fn, opts)
            vim.api.nvim_create_autocmd('BufWritePre', { callback = format_fn, buffer = bufnr })
          end


          if actions['source.organizeImports'] then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = { only = { 'source.organizeImports' } },
                })
              end
            })
          end
        end,
      })
    end
  }
}
