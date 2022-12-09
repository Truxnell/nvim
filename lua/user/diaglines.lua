local lua_lines_ok, cmp = pcall(require, "lua_lines")
if not lua_lines_ok then
	return
end

vim.diagnostic.config({ virtual_lines = false })
vim.diagnostic.config({ virtual_text = true })
