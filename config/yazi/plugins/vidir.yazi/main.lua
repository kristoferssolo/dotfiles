--- @sync entry
--- @since 25.2.7

return {
	entry = function()
		-- If no selection, use current directory (.)
		ya.manager_emit("shell", { "vidir .", block = true, confirm = true })
	end,
}
