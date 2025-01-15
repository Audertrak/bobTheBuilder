---@class bobTheBuilder
local M = {}

-- import submodule(s)
M.project = require("bobTheBuilder.project")
M.canHe = require("bobTheBuilder.canHe")
M.buildIt = require("bobTheBuilder.buildIt")
M.yesHeCan = require("bobTheBuilder.yesHeCan")
M.frameTheWindow = require("bobTheBuilder.frameTheWindow")

M.defaults = {
	-- language toolchain options; check for path and assign if exists
	toolchains = {
		zig = "zig.exe",
		clang = "clang.exe",
		gcc = "gcc.exe",
	},
	-- boilerplate paths for projects; will be created and used by plugin
	local_paths = {
		source_dir = "./src",
		build_dir = "./build",
		log_dir = "./log",
	},
	-- user added non-project paths; used for executables, targets, etc
	global_paths = {
	},
	-- project specific libraries for linking;
	project_libs = {
	},
	-- system and default libraries for linking
	sys_libs = {
		sys_lib_dir = "",
		sys_raylib_dir = "",
	},
	-- compilation targets
	targets = {
		windows = "windows",
		linux_x86 = "linux_x86",
		-- apple
		-- android
		-- ios
		-- arm
	},
}

---@param opts table: Config options passed by user
M.setup = function(opts)
	opts = opts or {}
	vim.notify("bobTheBuilder initialized with options: " .. vim.inspect(opts))

	-- keymap(s)
	-- ...

	M.defaults = vim.tbl_deep_extend("force", M.defaults, opts)

	M.frameTheWindow.openTheWindow()
	M.frameTheWindow.drawOnTheWindow("bobTheBuilder has moved in")
end

vim.api.nvim_create_user_command(
	'WindowShop',
	function()
		local bobTheBuilder = require('bobTheBuilder')
		-- close any existing window(s)  
		bobTheBuilder.frameTheWindow.closeTheWindow()
		-- open a new window and draw on it
		bobTheBuilder.frameTheWindow.openTheWindow()
		bobTheBuilder.frameTheWindow.drawOnTheWindow("bobTheBuilder has built a new window")

	end,
	{ desc = "Debug: test window drawing for functionality" }
)

return M
