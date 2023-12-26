vim.cmd("filetype plugin indent on")

require('plugins').setup()
require('autocmd').setup()
require('keymap').setup()

vim.g.mapleader = ","
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.compatible = false
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.hidden = true
vim.opt.history = 2000
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.listchars="tab:>-,trail:·"
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.path:append("**")
vim.opt.ruler = true
vim.opt.shortmess:append("c")
vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.tags = "./tags;/"
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.wrap = false

require('lualine').setup {
  options = {
    theme = 'dracula-nvim'
  }
}

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').pylsp.setup({})

vim.cmd[[colorscheme dracula-soft]]
