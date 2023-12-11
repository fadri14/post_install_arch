local state, alpha = pcall(require, "alpha")
if not state then
    return
end

local dashboard = require("alpha.themes.dashboard")
local fileProject = os.getenv("HOME") ..  "/.config/nvim/after/plugin/projects.txt"

function dashboardProject()
    local file = io.open(fileProject, "r")
    local int = 1

    if file then
        local keyProjects = "jklmhuiopy"

        for keyOneProject in keyProjects:gmatch(".") do
            local path = file:read("*l")
            if path == nil or path == "" then
                break
            end

            local name = string.match(path, "[^/]+$")

            table.insert(dashboard.section.buttons.val, dashboard.button(keyOneProject, int .. ": " .. name, ":cd " .. path .. " | lua Ranger()<CR>"))
            int = int + 1
        end

        file:close()
    else
        print("Erreur : Impossible d'ouvrir le fichier")
    end
end

dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

function dashboardBase()
    dashboard.section.buttons.val = {
        dashboard.button("e", "  > New file" , ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  > Find file", ":cd $HOME/ | Telescope find_files<CR>"),
        dashboard.button("r", "  > Recent"   , ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  > Settings" , ":cd $HOME/.config/nvim/ | lua Ranger()<CR>"),
        dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
        dashboard.button("a", "  > Ajouter un projet", ":lua addProject()<CR>"),
        dashboard.button("d", "  > Supprimer un projet", ":lua delProject()<CR>"),
        dashboard.button("l", "  > Les projets:", ""),
    }
end

function addProject()
    local path = vim.fn.getcwd()
    local file = io.open(fileProject, "a")
    if file then
        file:write(path .. "\n")
        file:close()
        dashboardBase()
        dashboardProject()
        vim.cmd("Alpha | Alpha")
    end
end

function delProject()
    local idProject = tonumber(vim.fn.input("Entrez le numéro du projet à supprimer: "))
    if not idProject or idProject <= 0 or idProject > 10 then
        return
    end

    local file = io.open(fileProject, "r")
    local tmpFilePath = os.getenv("HOME") ..  "/.config/nvim/after/plugin/tmp.txt"
    local tmpFile = io.open(tmpFilePath, "w")

    if file and tmpFile then
        local lineNumber = 1

        for line in file:lines() do
            if lineNumber ~= idProject then
                tmpFile:write(line, "\n")
            end
            lineNumber = lineNumber + 1
        end

        file:close()
        tmpFile:close()

        os.remove(fileProject)
        os.rename(tmpFilePath, fileProject)

        dashboardBase()
        dashboardProject()
        vim.cmd("Alpha | Alpha")
    end
end

dashboardBase()
dashboardProject()

-- Set footer
--   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
--   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
--   ```init.lua
--   return require('packer').startup(function()
--       use 'wbthomason/packer.nvim'
--       use {
--           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
--           requires = {'BlakeJC94/alpha-nvim-fortune'},
--           config = function() require("config.alpha") end
--       }
--   end)
--   ```
-- local fortune = require("alpha.fortune") 
-- dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
autocmd FileType alpha setlocal nofoldenable
]])

