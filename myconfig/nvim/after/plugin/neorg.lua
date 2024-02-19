local state, neorg = pcall(require, "neorg")
if not state then
	return
end

neorg.setup{
    load = {
        ["core.clipboard.code-blocks"] = {},
        ["core.esupports.hop"] = {},
        ["core.esupports.indent"] = {
            config = {
                indents = {
                    heading2 = { indent = 4 },
                    heading3 = { indent = 8 },
                    heading4 = { indent = 12 },
                    heading5 = { indent = 14 },
                    heading6 = { indent = 16 },
                },
            },
        },
        ["core.esupports.metagen"] = {},
        ["core.itero"] = {},
        ["core.journal"] = {},
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.unmap("norg", "n", "<leader>tu")
                    keybinds.unmap("norg", "n", "<leader>tp")
                    keybinds.unmap("norg", "n", "<leader>td")
                    keybinds.unmap("norg", "n", "<leader>th")
                    keybinds.unmap("norg", "n", "<leader>tc")
                    keybinds.unmap("norg", "n", "<leader>tr")
                    keybinds.unmap("norg", "n", "<leader>ti")
                    keybinds.unmap("norg", "n", "<leader>ta")

                    keybinds.map("norg", "n", "<leader>pu", "<cmd>Neorg keybind all core.qol.todo_items.todo.task_undone<CR>")
                    keybinds.map("norg", "n", "<leader>pp", "<cmd>Neorg keybind all core.qol.todo_items.todo.task_pending<CR>")
                    keybinds.map("norg", "n", "<leader>pd", "<cmd>Neorg keybind all core.qol.todo_items.todo.task_done<CR>")
                    keybinds.map("norg", "n", "<leader>ph", "<cmd>Neorg keybind all core.qol.todo_items.todo.task_on_hold<CR>")
                    keybinds.map("norg", "n", "<leader>pc", "<cmd>Neorg keybind all core.qol.todo_items.todo.task_cancelled<CR>")
                    keybinds.map("norg", "n", "<leader>pr", "<cmd>Neorg keybind all core.qol.todo_items.todo.task_recurring<CR>")
                    keybinds.map("norg", "n", "<leader>pi", "<cmd>Neorg keybind all core.qol.todo_items.todo.task_important<CR>")
                    keybinds.map("norg", "n", "<leader>pa", "<cmd>Neorg keybind all core.qol.todo_items.todo.task_ambiguous<CR>")

                    keybinds.map("norg", "n", "<leader>mt", "<cmd>Neorg mode traverse-heading<CR>")
                    keybinds.map("norg", "n", "<leader>ml", "<cmd>Neorg mode traverse-link<CR>")

                    keybinds.map("norg", "n", "<leader>q", "<cmd>Neorg journal today<CR>")

                    keybinds.map("norg", "n", "<leader>c", "<cmd>Neorg keybind all core.looking-glass.magnify-code-block")

                    keybinds.map("traverse-heading", "n", "<leader>mn", "<cmd>Neorg mode norg<CR>")
                    keybinds.map("traverse-heading", "n", "<leader>ml", "<cmd>Neorg mode traverse-link<CR>")
                    keybinds.map("traverse-heading", "n", "t", "<cmd>Neorg keybind all core.integrations.treesitter.next.heading<CR>")
                    keybinds.map("traverse-heading", "n", "s", "<cmd>Neorg keybind all core.integrations.treesitter.previous.heading<CR>")

                    keybinds.map("traverse-link", "n", "<leader>mn", "<cmd>Neorg mode norg<CR>")
                    keybinds.map("traverse-link", "n", "<leader>mt", "<cmd>Neorg mode traverse-heading<CR>")
                    keybinds.map("traverse-link", "n", "t", "<cmd>Neorg keybind all core.integrations.treesitter.next.link<CR>")
                    keybinds.map("traverse-link", "n", "s", "<cmd>Neorg keybind all core.integrations.treesitter.previous.link<CR>")

                    keybinds.map("presenter", "n", "t", "<cmd>Neorg keybind all core.integrations.treesitter.next.page<CR>")
                    keybinds.map("presenter", "n", "s", "<cmd>Neorg keybind all core.integrations.treesitter.previous.page<CR>")
                end,
            },
        },
        ["core.looking-glass"] = {},
        ["core.pivot"] = {},
        ["core.promo"] = {},
        ["core.qol.toc"] = {},
        ["core.qol.todo_items"] = {},
        ["core.tangle"] = {},
        ["core.upgrade"] = {},
        ["core.concealer"] = {
            config = {
                folds = false,
            }
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/Notes",
                    ml = "~/Documents/bac3/Q2/ML",
                    seminaire = "~/Documents/bac3/Q2/Seminaire",
                },
            },
        },
    },
}
