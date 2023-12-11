local options = {
	-- DISPLAY
	title = true,
	number = true,
	relativenumber = true,
	wrap = false,
	scrolloff = 12,
	sidescrolloff = 12,
	mouse = "a",
	cursorline = true,
	colorcolumn = "82", --set an vertical barre
	numberwidth = 2,
	textwidth = 0,
	shiftwidth = 4,
	tabstop = 4,
	expandtab = true,
	softtabstop = 4,
	fileencoding = "utf-8",
	signcolumn = "no",
	cmdheight = 1,
	showmode = false,
	splitbelow = true,
	splitright = true,
	smartindent = true,
	clipboard = "unnamedplus",
	laststatus = 2, -- set to 3 for an unique lualine bar.
	termguicolors = true, -- to enable highlight groups
	updatetime = 2000,
	-- SAVING
	backup = false,
	writebackup = false,
	swapfile = false,
	--undodir = vim.fn.expand("~") .. "/chemin/vers/dossier",
	--undofile = true,
	--undolevels = 500,
	-- SEARCH
	ignorecase = true,
	smartcase = true,
	hlsearch = true,
	-- REMOVE BEEP
	visualbell = true,
	errorbells = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

