return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        requires = {
            { "nvim-lua/plenary.nvim" }
        }
    }
    use("folke/tokyonight.nvim")
    use {
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        }
    }
    use {
        "nvim-lualine/lualine.nvim"
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use("tpope/vim-fugitive")
    use("lewis6991/gitsigns.nvim")
    use("jose-elias-alvarez/null-ls.nvim")
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }

    -- Debug Adapter Protocol
    use "mfussenegger/nvim-dap"
    use "mfussenegger/nvim-dap-python"
    use "rcarriga/nvim-dap-ui"
    use "leoluz/nvim-dap-go"
    use "theHamsta/nvim-dap-virtual-text"
    use "nvim-telescope/telescope-dap.nvim"
end)
