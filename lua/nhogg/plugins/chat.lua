return {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
        'zbirenbaum/copilot.lua', -- or 'github/copilot.vim'
        'nvim-lua/plenary.nvim'   -- for curl, log wrapper
    },
    config = function()
        require('CopilotChat').setup({
            debug = true, -- Enable debugging
            context = 'buffers', -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
            -- default window options
            window = {
                layout = 'float', -- 'float', vertical', 'horizontal'
                -- Options below only apply to floating windows
                relative = 'win', -- 'editor', 'win', 'cursor', 'mouse'
                border = 'double', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                width = 0.9, -- fractional width of parent
                height = 0.3, -- fractional height of parent
                row = 60, -- row position of the window, default is centered
                col = nil, -- column position of the window, default is centered
                title = 'Copilot Chat', -- title of chat window
                footer = nil, -- footer of chat window
                zindex = 1, -- determines if window is on top or below other floating windows
            },

            mappings = {
                complete = {
                    detail = '<C-f> is for finish',
                    insert ='<C-f>',
                },
                close = {
                    normal = 'q',
                    insert = '<C-c>'
                },
                reset = {
                    normal ='<C-l>',
                    insert = '<C-l>'
                },
                submit_prompt = {
                    normal = '<CR>',
                    insert = '<C-m>'
                },
                accept_diff = {
                    normal = '<C-y>',
                    insert = '<C-y>'
                },
            },
        })

        -- vim.api.nvim_set_keymap('n', '<leader>ap',{
            -- "<leader>aq",
            -- function()
                -- local input = vim.fn.input("Quick Chat: ")
                -- if input ~= "" then
                    -- require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                -- end
            -- end,
            -- desc = "CopilotChat - Quick chat",
        -- })

    end

}
