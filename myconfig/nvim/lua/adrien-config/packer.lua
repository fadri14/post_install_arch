-- Auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- Automatically source and re-sync packer when you save `packer.lua`.
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | PackerSync",
    group = packer_group,
    pattern = vim.fn.expand("packer.lua"),
})

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
    return
end

local packer_util_ok, packer_util = pcall(require, "packer.util")
if not packer_util_ok then
    return
end

-- Plugins
packer.startup({
    function(use)
        -- Packer manager
        use('wbthomason/packer.nvim')

        -- Colorscheme
        use('navarasu/onedark.nvim')
        use { "catppuccin/nvim", as = "catppuccin" }

        -- File explorer
        use('kelly-lin/ranger.nvim')

        -- Status line
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }

        -- Commentaries
        use('numToStr/Comment.nvim')

        -- Completion
        use('ervandew/supertab')

        -- Motion
        use {
            'phaazon/hop.nvim',
            branch = 'v2', -- optional but strongly recommended
            config = function()
                -- you can configure Hop the way you like here; see :h hop-config
                require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
            end
        }

        -- Telescope
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.4',
            requires = { {'nvim-lua/plenary.nvim'} }
        }

        -- Start
        use {
            'goolord/alpha-nvim',
            config = function ()
                require'alpha'.setup(require'alpha.themes.dashboard'.config)
            end
        }

        -- Scroll
       use('karb94/neoscroll.nvim')

        -- Treesitter
        use('nvim-treesitter/nvim-treesitter')

        -- Wakatime
        use ('wakatime/vim-wakatime')

    end,
    config = {
        display = {
            open_fn = function()
                return packer_util.float({ border = 'single' })
            end,
        },
    },
})

