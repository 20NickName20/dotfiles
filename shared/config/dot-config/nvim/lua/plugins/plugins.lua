return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local tree_cb = require'nvim-tree.config'.nvim_tree_callback
            require("nvim-tree").setup({
                actions = {
                    open_file = {
                        quit_on_open = false,  -- keep tree open
                        resize_window = true,
                        window_picker = {
                            enable = false, -- optional
                        },
                    },
                },
                view = {
                    width = 24,
                    side = "left",
                },
            })


            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
        end,
    },

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
                "typescript",
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
        "neovim/nvim-lspconfig",
    }
}

