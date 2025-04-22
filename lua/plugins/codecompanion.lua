return {
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        githubmodels = function()
          return require("codecompanion.adapters").extend("githubmodels", {
            schema = {
              model = {
                -- default = "Codestral-2501",
                default = "gpt-4.1",
              },
            },
          })
        end,
        coplitot = function()
            return require("codecompanion.adapters").extend("copilot", {
                schema = {
                model = {
                    -- default = "gpt-4o",
                    -- default = "claude-3.5-sonnet",
                    -- default = "claude-3.7-sonnet",
                    -- default = "gemini-2.5-pro",
                    -- default = "gemini-2.0-flash",
                },
                },
            })
            end,
      },
      strategies = {
        chat = {
          adapter = "githubmodels",
        },
        inline = {
          adapter = "githubmodels",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              description = "Reject the suggested change",
            },
          },
        },
        cmd = {
          adapter = "githubmodels",
        },
      },
      display = {
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff", -- default|mini_diff
        },
        chat = {
          intro_message = "Welcome to CodeCompanion ✨! Press ? for options BY PEDROOO",
          show_settings = true,
        },
      },
    },
  },
}
