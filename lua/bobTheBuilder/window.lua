local windowBlueprint = function()
	local height = math.ceil(vim.o.lines * 0.66)
	local width = math.ceil(vim.o.columns * 0.66)

	local headerHeight = 1 + 2
	local footerHeight = 1

	local bodyHeight = height - headerHeight - footerHeight - 2 - 1

	return {
		background = {
			relative = "editor",
			width = width,
			height = height,
			style = "minimal",
			border = "rounded",
			col = vim.api.nvim_win_get_width(0) / 2 - width / 2,
			row = vim.api.nvim_win_get_height(0) / 2 - height / 2,
			zindex = 1,
		},
		header = {
			relative = "editor",
			width = width - 2,
			height = 1,
			style = "minimal",
			border = "rounded",
			col = vim.api.nvim_win_get_width(0) / 2 - width / 2,
			row = vim.api.nvim_win_get_height(0) / 2 - height / 2,
			zindex = 2,
		},
		body = {
			relative = "editor",
			width = width - 8,
			height = bodyHeight,
			style = "minimal",
			border = { " ", " ", " ", " ", " ", " ", " ", " " },
			col = 8,
			row = 4,
		},
		footer = {
			relative = "editor",
			width = width - 2,
			height = 1,
			style = "minimal",
			border = "rounded",
			col = 1,
			row = height - 1,
			zindex = 3,
		},
	}
end

local function build_a_window(config, enter)
	if enter == nil then
		enter = false
	end

	local buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer
	local win = vim.api.nvim_open_win(buf, enter or false, config)

	return { buf = buf, win = win }
end

local trim_the_window = function()
	local window = windowBlueprint()
	background = build_a_window(window.background)
	header = build_a_window(window.header)
	footer = build_a_window(window.footer)
	body = build_a_window(window.background)
end


















---@class windowFrame
local M = {}

--local M.win, buf
M.win = nil
M.buf = nil

local function frameTheWindow()
	-- may want buffers per 'module'?
	if not M.buf or not vim.api.nvim_buf_is_valid(M.buf) then
		M.buf = vim.api.nvim_create_buf(false, true)
	end

	local opts = {
		relative = "editor",
		border = "rounded",
		style = "minimal",
		height = height,
		width = width,
	}

	if not M.win or vim.api.nvim_win_is_valid(M.win) then
		M.win = vim.api.nvim_open_win(M.buf, true, opts)
	end
end

M.openTheWindow = function()
	frameTheWindow()
end

M.closeTheWindow = function()
	if M.win and vim.api.nvim_win_is_valid(M.win) then
		vim.api.nvim_win_close(M.win, true)
		M.win = nil
	end
	if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
		vim.api.nvim_buf_delete(M.buf, { force = true })
		M.buf = nil
	end
end

---@param message string: The message to display
M.drawOnTheWindow = function(message)
	if not M.win or not vim.api.nvim_win_is_valid(M.win) then
		M.openTheWindow()
	end

	-- get the current contents of the buffer
	local lines = vim.api.nvim_buf_get_lines(M.buf, 0, -1, false)
	-- append the new message to the table
	table.insert(lines, message)
	-- update the contents of the buffer
	vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, lines)

	-- ensure the buffer is valid and has content before setting cursor
	local line_count = vim.api.nvim_buf_line_count(M.buf)
	if line_count > 0 then
		-- set the cursor to the last line
		vim.api.nvim_win_set_cursor(M.win, { #lines, 0 })
	end
end

return M
