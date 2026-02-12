return {

    'folke/lazy.nvim',
	'theprimeagen/harpoon',
	'mbbill/undotree',
    'saadparwaiz1/cmp_luasnip',

    'tpope/vim-fugitive',
    {'akinsho/git-conflict.nvim', version = "*", config = true},


    -- folding
    'tmhedberg/SimpylFold',
    'Konfekt/FastFold',

    -- use lua instead 'github/copilot.vim',
    { 
        "zbirenbaum/copilot.lua" ,
        requires = {
            "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
            init = function()
                vim.g.copilot_nes_debounce = 25
            end,
        },
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
                nes = { enabled = false, },
            })
        end,
    },

    'rafamadriz/friendly-snippets',

	{
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		-- or                            , branch = '0.1.x',
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},

    {
        "ellisonleao/gruvbox.nvim",
        config = function ()
            vim.o.background = "dark" -- or "light" for light mode
            vim.cmd([[colorscheme gruvbox]])
        end
    },

    'nvim-treesitter/nvim-treesitter',

	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			--- Uncomment these if you want to manage LSP servers from neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			-- LSP Support
			'neovim/nvim-lspconfig',
			-- Autocompletion
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
		}
	},

    { 
        'hrsh7th/nvim-cmp',
        config = function ()
            require'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                    end
                },

                sources = {
                    { name = 'luasnip', option = { use_show_condition = false } },
                    -- more sources
                },
            }
        end
    },-- Status Line (Powerline)
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'auto',
                    globalstatus = true,
                    section_separators = { left = '', right = ''},
                    component_separators = { left = '', right = ''},
                }
            })
        end
    },

}
