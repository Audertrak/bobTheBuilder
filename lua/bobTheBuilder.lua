---@class BobTheBuilder
local M = {}

-- potential functions
-- project
--	blueprint
--		draw
--		read
-- canHe
--	quote
--	estimate
-- buildIt
--	window
--		shop
--		frame
--		hang
--	demo
--	trimOut
--	cleanup
-- yesHeCan

local defaults = {
	-- top level option configures per language behavior; self extending list
	-- TODO; hook into vim api/treesitter to fetch context
	languages = {
		c = {
			-- allows for variation between operating systems
			dev_env = {
				windows_nt = {
					-- language toolchain options
					toolchains = {
						compiler = "zig cc", -- plugin should adapt compilation behavior based on selection
						-- lsp, linter, etc... used to include files like .clang-format
						-- potential plugin hook for 'code action' like behavior
						lsp = "clangd",
						linter = nil,
						formatter = "clang-format",
						debugger = "codelldb",
					},
					-- boilerplate paths for projects; will be created and used by plugin
					local_paths = {
						assets_dir = "./assests",
						source_dir = "./src",
						lib_dir = "./lib",
						build_dir = "./build",
						log_dir = "./log",
					},
					-- user added non-project paths; used for executables, targets, etc
					global_paths = {},
					-- project specific libraries for linking
					project_libraries = {},
					-- system and default libraries for linking
					system_libraries = {
						--stdlib
						--raylib
						--etc
					},
					-- compilation targets
					build_targets = {
						windows = "windows",
					},
				},
			},
		},
	},
}

-- expose defaults via opts for lazy
M.opts = defaults

---@param opts table: Config options passed by user
M.setup = function(opts)
	-- initialize configuration with default values
	M.config = vim.deepcopy(defaults)

	-- if exists, merge in user options
	if opts then
		M.config = vim.tbl_deep_extend("force", M.config, opts)
	end
end


return M
