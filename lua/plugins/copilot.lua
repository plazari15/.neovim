return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
          suggestion = {
            enabled = not vim.g.ai_cmp,
            auto_trigger = true,
            hide_during_completion = vim.g.ai_cmp,
            keymap = {
              accept = false, -- handled by nvim-cmp / blink.cmp
              next = "<C-]>",
              prev = "<C-[>",
            },
          },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
          },
        },
    },

    {
        "zbirenbaum/copilot-cmp",
        config = function ()
            local copilot_cmp = require("copilot_cmp")

            copilot_cmp.setup()

            LazyVim.lsp.on_attach(function()
                copilot_cmp._on_insert_enter({})
                end, "copilot")
        end,
      },
      
}