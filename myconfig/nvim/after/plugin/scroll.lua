local state, neoscroll = pcall(require, "neoscroll")
if not state then
    return
end

neoscroll.setup({
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = false,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})

local key = {}
key['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '300'}}
key['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '300'}}
key['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
key['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450'}}
key['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
key['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
key['zt']    = {'zt', {'250'}}
key['zz']    = {'zz', {'250'}}
key['zb']    = {'zb', {'250'}}

require('neoscroll.config').set_mappings(key)

