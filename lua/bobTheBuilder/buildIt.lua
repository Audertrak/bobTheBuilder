---@class buildIt
local M = {}

M.build_loaded = false
M.build_buf, M.build_win = nil, nil

function M.launch_build()
	if not M.build_loaded or not vim.api.nvim_win_is_valid(M.build_win) then
		if not M.build_buf or not vim.api.nvim_buf_is_valid(M.build_buf) then
			-- create the buffer
			M.build_buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_option(M.build_buf, "bufhidden", "hide")
			vim.api.nvim_buf_set_option(M.build_buf, "filetype", "markdown")
			vim.api.nvim_buf_set_option(M.build_buf, 0, 1, false, {
				"# Build",
				"",
				"> Buffer will clear when curren session closes",
			})
		end

		-- create the window
		M.build_win = vim.api.nvim_open_win(M.build_buf, true, {
			border = "rounded",
			relative = "editor",
			style = "minimal",
			height = math.ceil(vim.o.lines * 0.66),
			width = math.ceil(vim.o.columns * 0.66),
			row = 1,
			col = 1,
		})
		vim.api.nvim_win_set_option(M.build_win, "winblend", 30) -- sets buffer to semi-transparent

		-- set keymappings local for the window
		local keymaps_opts = { silent = true, buffer = M.build_buf }
		vim.keymap.set("n", "<ESC>", function()
			M.launch_build()
		end, keymap_opts)
		vim.keymap.set("n", "q", function()
			M.launch_notepad()
		end, keymaps_opts)
	else
		vim.api.nvim_win_hide(M.build_win)
	end

	-- toggle status
	M.build_loaded = not M.build_loaded
end

vim.keymap.set("n", "<leader>bt", function()
	require("bobTheBuilder").launch_build()
end, { desc = "Toggle the builder dialogue" })

return M
