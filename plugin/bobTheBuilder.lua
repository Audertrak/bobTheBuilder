vim.api.nvim_create_user_command("BuildStart", function()
	require("bobTheBuilder").launch_build()
end, {})
