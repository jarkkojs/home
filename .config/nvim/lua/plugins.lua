local M = {}

local plugins = {
  'ap/vim-buftabline',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
  },
  'mmarchini/bpftrace.vim',
  'vim-scripts/git_patch_tags.vim',
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }, 
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  },
  'Mofiqul/dracula.nvim',
}

function M.setup()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup(plugins, opts)
end

return M
