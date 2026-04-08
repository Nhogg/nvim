_G.FoldAllDocstrings = function()
    vim.api.nvim_command('setlocal foldmethod=manual')  -- Temporarily switch to manual fold method
    local in_docstring = false
    local docstring_start = 0

    local isDocString = function(line)
        return line:match('"""') or line:match('\'\'\'') and not line:match('""".*"""')
    end

    for lnum = 1, vim.api.nvim_buf_line_count(0) do
        local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
        -- print(line:match('""".*"""'))
        -- print(lnum)
        if in_docstring then
            if isDocString(line) then
                if (lnum ~= docstring_start) then
                    -- print('folding')
                    vim.api.nvim_command(docstring_start .. ',' .. lnum .. 'fold')
                    vim.api.nvim_command(docstring_start .. 'foldclose')  -- Close the fold
                end
                in_docstring = false
            end
        else
            if isDocString(line) and not line:match('""".*"""') then
                docstring_start = lnum
                in_docstring = true
            end
        end
    end
    if in_docstring then
        vim.api.nvim_command(docstring_start .. ',' .. (lnum - 1) .. 'fold')
    end
    vim.api.nvim_command('setlocal foldmethod=expr')  -- Switch back to expression fold method
end
vim.keymap.set("n","<leader>9", ":lua FoldAllDocstrings()<CR>")
vim.keymap.set("n", "<leader>8", "/\\v(def|class)")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal textwidth=100",
  command = "setlocal colorcolumn=100",
})

-- Auto-wrap markdown at 100 columns
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 100
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.formatoptions:append("t")  -- auto-wrap text
  end,
})
