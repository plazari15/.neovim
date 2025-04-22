-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.g.mapleader = " "
-- vim.g.maplocalleader = ";"

-- Remap ESC no terminal --
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- explorer files
-- vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")

-- Split window
vim.keymap.set("n", "ss", "<cmd>split<CR>")
vim.keymap.set("n", "sv", "<cmd>vsplit<CR>")
vim.keymap.set("n", "sq", "<C-w>q")

-- Move window
vim.keymap.set("n", "sh", "<C-w>h") -- Direita
vim.keymap.set("n", "sk", "<C-w>k") -- Cima
vim.keymap.set("n", "sj", "<C-w>j") -- baixo
vim.keymap.set("n", "sl", "<C-w>l") -- esquerda

-- LS divide de maneira horizontal
-- LV divide de maneira vertical

-- Tab movement lines
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

vim.keymap.set("n", "<C-f>", "<FzfLua live_grep>", { desc = "PRIORIDADE" })

-- ONLY TESTS
vim.keymap.set("n", "tt", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
vim.keymap.set("n", "<leader>ft", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

-- TABS --

-- Criar uma nova tab
vim.keymap.set("n", "<leader>tN", "<cmd>tabnew<CR>", { desc = "Nova Tab" })

-- Fechar a tab atual
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Fechar Tab" })

-- Alternar entre tabs
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { desc = "Próxima Tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { desc = "Tab Anterior" })

-- Mover tab
vim.keymap.set("n", "<leader>tmr", ":tabmove +1<CR>", { desc = "Mover Tab Direita" })
vim.keymap.set("n", "<leader>tml", ":tabmove -1<CR>", { desc = "Mover Tab Esquerda" })

-- Alternar entre tabs rapidamente
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { desc = "Próxima aba" })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { desc = "Aba anterior" })

-- Ir para a primeira e última aba
vim.keymap.set("n", "<leader>tf", ":tabfirst<CR>", { desc = "Primeira aba" })
vim.keymap.set("n", "<leader>tl", ":tablast<CR>", { desc = "Última aba" })

-- FIM TABS --

-- KEYMAP para meu comando Repl
vim.keymap.set("n", "<leader>rr", ":NuRepl<CR>", { desc = "Executa Lein Especifico" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renomeia usando o LSP" })
vim.keymap.set("n", "<leader>fk", ":%s//g<Left><Left>", { noremap = true, silent = false })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, desc = "Abre o modal com o erro" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, desc = "Go to prev error" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, desc = "Go to next error" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,  { noremap = true, desc = "" })

-- LocalLedder for CodeCompanion
vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ab", ":CodeCompanion #buffer ", { noremap = true, silent = false })

