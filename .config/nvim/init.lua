vim.cmd("filetype plugin indent on")
vim.cmd [[packadd packer.nvim]]

local function plugins(use)
  use 'wbthomason/packer.nvim'
  use 'ap/vim-buftabline'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'mmarchini/bpftrace.vim'
  use 'vim-scripts/git_patch_tags.vim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    {'neovim/nvim-lspconfig'},
    {
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use 'Mofiqul/dracula.nvim'
end

require('packer').startup(plugins)

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
vim.opt.path:append("**")
vim.opt.ruler = true
vim.opt.shortmess:append("c")
vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.tags = "./tags;/"
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.wrap = false

local function map(mode, shortcut, command)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, shortcut, command, opts)
end

map('n', "<silent>", "<C-l> :nohl<CR><C-l>")
map('n', "<leader>cd", ":lcd %:p:h<CR>:pwd<CR>")

local buf_check = vim.api.nvim_create_augroup("BufCheck", { clear = true })

vim.api.nvim_create_autocmd(
  { "FocusGained", "BufEnter" },
  { pattern = "*", command = [[:checktime]], group = buf_check }
)

require('lualine').setup {
  options = {
    theme = 'dracula-nvim'
  }
}

require('Comment').setup()

vim.cmd[[colorscheme dracula-soft]]

--
-- Language Server Protocol (LSP)
--

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Create your keybindings here...

    local fmt = function(cmd) return function(str) return cmd:format(str) end end
    local buffer = vim.api.nvim_get_current_buf()
    local lsp = fmt('<cmd>lua vim.lsp.%s<cr>')
    local diagnostic = fmt('<cmd>lua vim.diagnostic.%s<cr>')

    map('n', '<leader>K', lsp 'buf.hover()')
    map('n', '<leader>gd', lsp 'buf.definition()')
    map('n', '<leader>gD', lsp 'buf.declaration()')
    map('n', '<leader>gi', lsp 'buf.implementation()')
    map('n', '<leader>go', lsp 'buf.type_definition()')
    map('n', '<leader>gr', lsp 'buf.references()')
    map('n', '<leader>gs', lsp 'buf.signature_help()')
    map('n', '<F2>', lsp 'buf.rename()')
    map('n', '<F3>', lsp 'buf.format({async = true})')
    map('x', '<F3>', lsp 'buf.format({async = true})')
    map('n', '<F4>', lsp 'buf.code_action()')

    if vim.lsp.buf.range_code_action then
      map('x', '<F4>', lsp 'buf.range_code_action()')
    else
      map('x', '<F4>', lsp 'buf.code_action()')
    end

    map('n', '<leader>gl', diagnostic 'open_float()')
    map('n', '<leader>[d', diagnostic 'goto_prev()')
    map('n', '<leader>]d', diagnostic 'goto_next()')
  end
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
  }
})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = lsp_capabilities,
    })
  end,
})
