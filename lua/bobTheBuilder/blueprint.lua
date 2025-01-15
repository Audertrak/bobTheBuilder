local M = {}

local builder = require("bobTheBuilder")

local function get_context()
	local ft = vim.bo.filetype
	local os = vim.loop.os_uname().sysname:lower()

	if builder.config.languages[ft] and builder.config.languages[ft].dev_env[os] then
		return builder.config.languages[ft].dev_env[os]
	end

	return nil
end

function M.draft_blueprints(local_paths)
	local context = get_context()
	if context then
		local project_dir = vim.fn.getcwd()
		for path in pairs(local_paths) do
			local dir = project_dir .. "/" .. path
			if vim.fn.isdirectory(dir) == 0 then
				local cmd = "mkdir -p " .. dir
				vim.fn.system(cmd)
			end
		end
	else
		vim.notify("Unable to obtain configuration for environment", vim.log.levels.WARN)
	end

	M.draft_blueprints(context.local_paths)

return M
