return {
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
            "neovim/nvim-lspconfig",
        },
        ft = { "quarto", "markdown" },
        opts = {
            lspFeatures = {
                enabled = true,
                chunks = "curly",
                languages = { "python", "r", "julia", "bash", "html" },
                diagnostics = {
                    enabled = true,
                    triggers = { "BufWritePost" },
                },
                completion = {
                    enabled = true,
                },
            },
            codeRunner = {
                enabled = true,
                default_method = "molten",
            },
        },
    },
}
