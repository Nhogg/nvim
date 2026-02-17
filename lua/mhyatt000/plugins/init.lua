return {
    'folke/lazy.nvim',

    'theprimeagen/harpoon',
    'mbbill/undotree',
    'saadparwaiz1/cmp_luasnip',
    'tpope/vim-fugitive',
    { 'akinsho/git-conflict.nvim', version = "*", config = true },

    'tmhedberg/SimpylFold',
    'Konfekt/FastFold',

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 25,
                    trigger_on_accept = true,
                    keymap = {
                        accept = "<Tab>",
                        accept_word = "<M-w>",
                        accept_line = "<M-l>",
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<S-Esc>",
                    },
                },
                nes = { enabled = false },
            })
        end,
    },

    'rafamadriz/friendly-snippets',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            vim.o.background = "dark"
            vim.cmd([[colorscheme gruvbox]])
        end
    },

    'nvim-treesitter/nvim-treesitter',

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        }
    },

    {
        'hrsh7th/nvim-cmp',
        config = function()
            require 'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require 'luasnip'.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'luasnip', option = { use_show_condition = false } },
                },
            }
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'auto',
                    globalstatus = true,
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                }
            })
        end
    },

    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents/Obsidian_Notes",
                },
            },
            legacy_commands = false,
            ui = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("obsidian").setup(opts)
            vim.opt.conceallevel = 2
        end,
    },
}
