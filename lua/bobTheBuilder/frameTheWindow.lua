---@class windowFrame
local M = {}

local win, buf

local function frameTheWindow()
	-- may want buffers per 'module'?
	buf = vim.api.nvim_create_buf(false, true)

	local height = math.ceil(vim.o.lines * 0.66)
	local width = math.ceil(vim.o.columns * 0.66)

	local opts = {
		relative = "editor",
		border = "rounded",
		style = "minimal",
		height = height,
		width = width,
		col = vim.api.nvim_win_get_width(0) / 2 - width / 2,
		row = vim.api.nvim_win_get_height(0) / 2 - height / 2,
	}

	win = vim.api.nvim_open_win(buf, true, opts)
end

M.openTheWindow = function()
	if not win then
		frameTheWindow()
	end

	-- TODO: clear contents of buffer/window
end

M.closeTheWindow = function()
	if win then
		vim.api.nvim_win_close(win, true)
		win = nil
	end
end

---@param message string: The message to display
M.drawOnTheWindow = function(message)
	if not win then
		M.openTheWindow()
	end

	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	table.insert(lines, message)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	vim.api.nvim_win_set_cursor(win, { #lines + 1, 0 })
end

return M
