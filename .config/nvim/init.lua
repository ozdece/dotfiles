require("core")

-- lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.cursorline = true

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end


-- Plugins

local plugin_telescope = {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
}
local plugin_treesitter = {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        vim.cmd("TSUpdate")
    end
}

local plugin_colorscheme = { "rebelot/kanagawa.nvim", config = {theme = "wave", keywordStyle = {italic = false}}, priority = 1000 }

local plugin_undotree = "mbbill/undotree"
local plugin_vim_figutive = "tpope/vim-fugitive"
local plugin_lsp_zero = {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim',
        build = function()
            pcall(vim.cmd, 'MasonUpdate')
        end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
}
}

local plugin_neo_tree = {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = {
        default_component_configs = {
            icon = {
                folder_empty = "󰜌",
                folder_empty_open = "󰜌",
            },
            git_status = {
                symbols = {
                    renamed   = "󰁕",
                    unstaged  = "󰄱",
                },
            },
        },
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false
            }
        },
        document_symbols = {
            kinds = {
                File = { icon = "󰈙", hl = "Tag" },
                Namespace = { icon = "󰌗", hl = "Include" },
                Package = { icon = "󰏖", hl = "Label" },
                Class = { icon = "󰌗", hl = "Include" },
                Property = { icon = "󰆧", hl = "@property" },
                Enum = { icon = "󰒻", hl = "@number" },
                Function = { icon = "󰊕", hl = "Function" },
                String = { icon = "󰀬", hl = "String" },
                Number = { icon = "󰎠", hl = "Number" },
                Array = { icon = "󰅪", hl = "Type" },
                Object = { icon = "󰅩", hl = "Type" },
                Key = { icon = "󰌋", hl = "" },
                Struct = { icon = "󰌗", hl = "Type" },
                Operator = { icon = "󰆕", hl = "Operator" },
                TypeParameter = { icon = "󰊄", hl = "Type" },
                StaticMethod = { icon = '󰠄 ', hl = 'Function' },
            }
        }
    }
}

local plugin_treesj = {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesj').setup({})
    end,
}

local nvimplugins = {
    plugin_telescope,
    plugin_colorscheme,
    plugin_treesitter,
    plugin_undotree,
    plugin_vim_figutive,
    plugin_lsp_zero,
    plugin_neo_tree,
    plugin_treesj
}

-- Plugins end

require("lazy").setup(nvimplugins)

-- Setting up colorscheme
vim.cmd.colorscheme("kanagawa")
vim.cmd.set("number relativenumber")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

