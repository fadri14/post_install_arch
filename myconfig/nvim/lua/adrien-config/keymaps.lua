local key = vim.keymap.set
local full_options = { noremap = true, silent = true }
local noremap = { noremap = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- change key for bepo
key('n', 'c', 'h', full_options)
key('n', 't', 'j', full_options)
key('n', 's', 'k', full_options)
key('n', 'r', 'l', full_options)

key('n', 'C', 'H', full_options)
key('n', 'T', 'J', full_options)
key('n', 'S', 'K', full_options)
key('n', 'R', 'L', full_options)

key('n', 'h', 'c', full_options)
key('n', 'j', 't', full_options)
key('n', 'k', 's', full_options)
key('n', 'l', 'r', full_options)

key('n', 'H', 'C', full_options)
key('n', 'J', 'T', full_options)
key('n', 'K', 'S', full_options)
key('n', 'L', 'R', full_options)

key('v', 'c', 'h', full_options)
key('v', 't', 'j', full_options)
key('v', 's', 'k', full_options)
key('v', 'r', 'l', full_options)

key('v', 'C', 'H', full_options)
key('v', 'T', 'J', full_options)
key('v', 'S', 'K', full_options)
key('v', 'R', 'L', full_options)

key('v', 'h', 'c', full_options)
key('v', 'j', 't', full_options)
key('v', 'k', 's', full_options)
key('v', 'l', 'r', full_options)

key('v', 'H', 'C', full_options)
key('v', 'J', 'T', full_options)
key('v', 'K', 'S', full_options)
key('v', 'L', 'R', full_options)

-- Basic
key('n', '<leader>d', 'gg0vG$d', full_options)
key('n', '<leader>i', 'gg=G`.<CR>', full_options)
key('n', '<leader>w', '<C-w>w', full_options)
key('n', '<leader>s', '<C-w>v', full_options)
key('n', '<leader>n', ':noh<CR>', full_options)
key('n', '<leader>u', '<C-r>', full_options)
key('v', '<leader>y', '"+y', full_options)
key('n', 'à', ':w<CR>', full_options)
key('n', 'ê', ':q<CR>', full_options)
key('n', 'é', 'w', full_options)
key('v', 'é', 'w', full_options)

-- Ranger
key("n", "<leader>r", "", {
	noremap = true,
	callback = function()
		require("ranger-nvim").open(true)
	end,
})

function Ranger()
		require("ranger-nvim").open(true)
end

-- Hop
key('n', 'f', ':HopChar1<CR>', noremap)
key('n', '<leader>l', ':HopLineStart<CR>', noremap)

-- Telescope
local builtin = require('telescope.builtin')
key('n', '<leader>t', builtin.find_files, {})
key('n', '<leader>g', builtin.live_grep, {})
key('n', '<leader>b', builtin.buffers, {})

-- Alpha
key('n', '<leader>a', ':Alpha<CR>', full_options)

-- Neorg
key('n', '<leader>àn', ':Neorg workspace notes<CR>', full_options)
key('n', '<leader>àm', ':Neorg workspace ml<CR>', full_options)
key('n', '<leader>j', ':Neorg journal today<CR>', full_options)
key('n', "<leader>c", ":Neorg keybind all core.looking-glass.magnify-code-block<CR>")

