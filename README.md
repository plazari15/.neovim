# 📖 Neovim Plugin Setup - LazyVim

![Futuristic Neovim Setup](attachment://An_illustration_of_a_futuristic,_cyberpunk-style_N.png)

Este repositório contém a configuração dos plugins do **Neovim** utilizando o **LazyVim** como gerenciador de plugins. Além dos plugins instalados, também documenta **keymaps personalizados**, **comandos customizados** e os **extras** utilizados para melhorar o fluxo de trabalho no Neovim.

---

## 📦 Plugins Instalados

🔹 **Avante**
- Integração com **Copilot** para sugestões automáticas.
- Suporte a diferentes **provedores de IA** para código.
- Funcionalidade para **colar imagens diretamente** no Neovim.
- Compatível com **Telescope**, **FZF**, **nvim-cmp**, entre outros.

🔹 **Baleia**
- Permite **colorir logs e saídas ANSI** no Neovim.
- Inclui os comandos `:BaleiaColorize` e `:BaleiaLogs` para manipulação de cores.

🔹 **Blink**
- **Autocompletar inteligente** integrado com **nvim-cmp**.
- Suporte para **ghost text**, snippets e símbolos customizados.
- Mapeamento de teclas para **aceitação e navegação** entre sugestões.

🔹 **Blink CMP**
- Complemento para **Blink**, adicionando integração com **LazyDev**.
- Ajusta ícones e estilos para **melhor compatibilidade visual**.

🔹 **Conjure**
- Ambiente interativo para desenvolvimento com **linguagens dinâmicas** como **Clojure**.
- Integração com **Baleia** para logs coloridos.
- Mapeamentos para navegar entre saídas de avaliações.

🔹 **Lualine**
- **Statusline customizável** e responsiva.
- Suporte a **ícones**, **diagnósticos**, **modo DAP** e integração com **LazyVim**.
- Ajuste automático de **visibilidade** dependendo do contexto.

🔹 **Mason**
- Gerenciador de instalação de **servidores LSP**, **formatadores** e **linters**.
- Automatiza a instalação de ferramentas como **stylua** e **shfmt**.
- Atualização automática via `:MasonUpdate`.

🔹 **Mason LSP Config**
- Configuração automática do **Mason** para servidores **LSP** compatíveis.
- Integração com **lspconfig** para facilitar o setup.

🔹 **Neogit**
- Interface interativa para **Git** no Neovim, similar ao **Magit** do Emacs.
- Atalho `<leader>gs` para abrir a interface do **Neogit**.
- Integração com **Diffview**, **GitSigns** e **GitLinker**.

🔹 **Git Helpers**
- Mostra alterações no código diretamente no **gutter** do Neovim.
- **Blame inline** para cada linha modificada (`<leader>gb`).
- Visualização rápida de **hunks** (`<leader>gd`).

🔹 **nvim-lspconfig**
- Facilita a configuração de **LSPs** no Neovim.
- Suporte a **diagnósticos**, **inlay hints**, **codelens** e mais.
- Integração com **Mason** para instalação automática de servidores LSP.

🔹 **nvim-treesitter**
- **Melhora a análise e realce de sintaxe** no Neovim.
- Suporte a **incremental selection**, **text objects** e **movimentação semântica**.
- Atualização automática via `:TSUpdate`.

🔹 **nvim-treesitter-sexp**
- **Extensão para manipulação de S-expressions** no Neovim.
- Suporte aprimorado para **Lisp e Clojure**.

🔹 **todo-comments**
- **Destaca palavras-chave** como `TODO`, `FIXME`, `HACK` no código.
- Comandos para **pesquisa e navegação rápida** de comentários `TODO`.
- Integração com **fzf** para listagem (`<leader>Sc` e `<leader>Td`).

🔹 **marks.nvim**
- **Gerenciamento avançado de marcas** no Neovim.
- Listagem rápida de marcas (`<leader>lg`, `<leader>la`).
- Suporte a **múltiplos grupos de bookmarks**.

---

## ⌨️ Keymaps Customizados

Aqui estão os **keymaps personalizados** configurados para otimizar o fluxo de trabalho no Neovim:

### 📂 **Navegação e Manipulação de Arquivos**
- `<leader>e` - **Abrir/Fechar Explorer** (Neotree).
- `<C-f>` - **Pesquisa Rápida** usando FzfLua.

### 🔀 **Gerenciamento de Janelas**
- `ss` - **Dividir Horizontalmente**.
- `sv` - **Dividir Verticalmente**.
- `sq` - **Fechar Janela**.
- `sh / sk / sj / sl` - **Mover entre janelas**.

### 🗂 **Gerenciamento de Tabs**
- `<leader>tN` - Criar nova tab.
- `<leader>tc` - Fechar tab atual.
- `<leader>tn / <leader>tp` - Alternar entre tabs.
- `<leader>tmr / <leader>tml` - Mover tab.
- `<Tab> / <S-Tab>` - Alternar rapidamente entre tabs.

### 📜 **Comandos Customizados**
- `<leader>rr` - **Executar REPL do Nubank** (Lein com perfis específicos).
- `<leader>rn` - **Renomear utilizando LSP**.
- `<leader>d` - **Abrir erro/diagnóstico em um modal**.
- `[d / ]d` - **Navegar entre erros**.

---

## 🚀 Instalação

1. Certifique-se de que o **LazyVim** está configurado corretamente.
2. Copie os arquivos `.lua` deste repositório para:
   ```sh
   ~/.config/nvim/lua/plugins/
   ```
3. Instale e atualize os plugins com:
   ```vim
   :Lazy sync
   ```

---

## 📜 Licença

Este repositório segue a licença **MIT**.
