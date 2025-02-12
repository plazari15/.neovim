-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.g.mapleader = " "
-- vim.g.maplocalleader = ";"

-- Remap ESC no terminal --
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Split window
vim.keymap.set("n", "ss", "<cmd>split<CR>")
vim.keymap.set("n", "sv", "<cmd>vsplit<CR>")
vim.keymap.set("n", "sq", "<C-w>q")

-- Move window
vim.keymap.set("n", "sh", "<C-w>h") -- Direita
vim.keymap.set("n", "sk", "<C-w>k") -- Cima
vim.keymap.set("n", "sj", "<C-w>j")  -- baixo
vim.keymap.set("n", "sl", "<C-w>l") -- esquerda



-- LS divide de maneira horizontal
-- LV divide de maneira vertical


vim.keymap.set("n", "<C-f>", "<FzfLua live_grep>", { desc = "PRIORIDADE" })
