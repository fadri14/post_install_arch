local state, telescope = pcall(require, "telescope")
if not state then
    return
end

telescope.setup{
    defaults = {
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = {"node_modules", ".git"},
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,

        mappings = {
            i = {
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<leader>j"] = require('telescope.actions').move_selection_next,
                ["<leader>k"] = require('telescope.actions').move_selection_previous,
                ["<leader>t"] = require('telescope.actions').close,
                ["<leader>i"] = require('telescope.actions').select_tab,
            }
        }
    },
    pickers = {
        find_files = {
            find_command = {'rg', '--files', '--hidden', '-g', '!.git', '-g', '!node_modules'}
        },
        grep_string = {
            search = function(prompt)
                return {
                    {'rg', '--hidden', '--smart-case', '--no-heading', '--with-filename', '--line-number', prompt},
                }
            end
        }
    }
}

