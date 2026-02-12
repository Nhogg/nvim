require("mhyatt000")

vim.opt.number = true
vim.opt.relativenumber = true

-- Comment plugins
local comment_styles = {
  c = { start = "/*", mid = " * ", stop = " */" },
  cpp = { start = "/*", mid = " * ", stop = " */" },
  java = { start = "/**", mid = " * ", stop = " */" }, -- Javadoc style
  python = { start = '"""', mid = "", stop = '"""' },
  lua = { start = "--[[", mid = "", stop = "--]]" },
  sh = { start = ": '", mid = "", stop = "' " }, -- Shell heredoc hack
}

vim.api.nvim_create_user_command('Ic', function()
  -- Get current file extension / type
  local ft = vim.bo.filetype
  local style = comment_styles[ft]

  -- Default if type unknown
  if not style then
    print("No block comment style defined for " .. ft)
    return
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  local lines = {}
  if ft == "python" then
    lines = { style.start, "", style.stop }
  else
    lines = { style.start, style.mid, style.stop }
  end

  vim.api.nvim_buf_set_lines(0, row, row, false, lines)

  local target_col = #style.mid
  if ft == "python" then target_col = 0 end

  vim.api.nvim_win_set_cursor(0, { row + 2, target_col })

  vim.cmd('startinsert!')
end, {})
