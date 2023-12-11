local state, ranger = pcall(require, "ranger")
if not state then 
	return
end

ranger.setup({
	replace_netrw = true
})

