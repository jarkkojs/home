local M = {}

function M.setup()
  vim.api.nvim_create_autocmd(
    {"FocusGained", "BufEnter" },
    {
      pattern = "*",
      command = [[:checktime]],
      group = vim.api.nvim_create_augroup("BufCheckTime", { clear = true })
    }
  )
end

return M
