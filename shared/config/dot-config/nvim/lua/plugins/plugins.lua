return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        opts = {
            ensure_installed = {
                "lua",
                "python",
                "rust"
            },
            highlight = { enable = true },
            indent = { enable = true },
        }
    },

    { "nvim-telescope/telescope.nvim" },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "rust_analyzer",
                },
            })
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },

        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),

                sources = {
                    { name = "nvim_lsp" },
                },
            })
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities
            })
        end,
    },

    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            -- optional picker via telescope
            {"nvim-telescope/telescope.nvim"},
            -- optional picker via fzf-lua
            {"ibhagwan/fzf-lua"},
            -- .. or via snacks
            {
              "folke/snacks.nvim",
              opts = {
                terminal = {},
              }
            }
        },
        event = "LspAttach",
        opts = {},
    },

    {
        "neovim/nvim-lspconfig",
    }
}

