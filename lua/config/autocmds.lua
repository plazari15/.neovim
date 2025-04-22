-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- COMANDO QUE ABRE O REPL

vim.api.nvim_create_user_command("NuRepl", function()
  vim.cmd("Lein with-profile +unit,+integration,+dev repl")
end, {})

-- FIM COMANDO QUE ABRE O REPL

-- COMANDO QUE VAI ORGANIZAR OS IMPORTS --
vim.api.nvim_create_user_command("CleanNs", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply = true,
  })
end, {})
