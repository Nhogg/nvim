-- READ THIS!
-- https://github.com/VonHeikemen/lsp-zero.nvim

local lsp = require('lsp-zero')
require('cmp_luasnip')

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()

require('luasnip.loaders.from_vscode').lazy_load()
-- to add framework
-- require'luasnip'.filetype_extend("ruby", {"rails"})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local builtin = require('telescope.builtin')

    -- UPDATED: Uses Telescope for a fuzzy-searchable definition list
    vim.keymap.set("n", "gd", function() builtin.lsp_definitions() end, opts)

    -- UPDATED: The "In-Context" grep for all function calls/references
    vim.keymap.set("n", "<leader>vrr", function() builtin.lsp_references() end, opts)

    -- UPDATED: Search for symbols (functions/variables) in the current workspace
    vim.keymap.set("n", "<leader>vws", function() builtin.lsp_dynamic_workspace_symbols() end, opts)

    -- Keep these as standard (Telescope doesn't handle these specific UI actions)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    if client:supports_method('textDocument/inlayHint') then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end)

local function find_venv_path(start_dir)
    local uv = vim.uv or vim.loop
    local dir = start_dir or uv.cwd()

    while dir do
        local venv_path = dir .. "/.venv"
        local venv_stat = uv.fs_stat(venv_path)
        if venv_stat and venv_stat.type == "directory" then
            return venv_path
        end

        local parent_dir = uv.fs_realpath(dir .. "/..")
        if parent_dir == dir or parent_dir == nil then
            break
        end
        dir = parent_dir
    end

    return nil
end

local function python_settings(root_dir)
    local venv = os.getenv("VIRTUAL_ENV") or find_venv_path(root_dir)
    local settings = {
        analysis = {
            autoImportCompletions = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
        },
    }
    if venv then
        settings.venvPath = vim.fn.fnamemodify(venv, ":h")
        settings.venv = vim.fn.fnamemodify(venv, ":t")
        settings.pythonPath = venv .. "/bin/python"
    end
    return settings
end


require('mason').setup({})

vim.lsp.config('lua_ls', lsp.nvim_lua_ls())
vim.lsp.config('pyright', {
    settings = {
        python = python_settings(vim.fn.getcwd()),
    },
})

require('mason-lspconfig').setup({
    ensure_installed = {
        'pyright',
        'rust_analyzer',
        'eslint',
        "ts_ls",
    },
    automatic_enable = true,
})


cmp.setup({
    formatting = {
        -- changing the order of fields so the icon is the first
        fields = { 'menu', 'abbr', 'kind' },
        -- here is where the change happens
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
                nvim_lua = 'Π',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },

    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'cmp_luasnip' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    },

    mapping = cmp.mapping.preset.insert({
        -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        -- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<leader><Tab>'] = cmp.mapping.confirm({ select = true }), -- was '<C-y>'
        ['<S-Tab>'] = cmp.mapping.confirm({ select = true }), -- was '<C-y>'
        -- ['<C-Tab>'] = cmp_action.luasnip_supertab(),
        -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        -- ['<C-Space>'] = cmp.mapping.complete(),
    }),
})


--[[
        ['<C-p>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item({behavior = 'insert'})
          else
            cmp.complete()
          end
        end),
        ['<C-n>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item({behavior = 'insert'})
          else
            cmp.complete()
          end
        end),
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
--]]
