local M = {}

local function nmap(mode, shortcut, command)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, shortcut, command, opts)
end

function M.setup()
  nmap('n', "<silent>", "<C-l> :nohl<CR><C-l>")
  nmap('n', "<leader>lcd", ":lcd %:p:h<CR>:pwd<CR>")
  nmap('n', "<leader>n", ":lua vim.o.number = not vim.o.number<CR>")
end

return M
