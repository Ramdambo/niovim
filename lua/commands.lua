local CONFIG_PATH = "~/.config/nvim/"

vim.api.nvim_create_user_command('OpenConfig', function(opts)
	-- TODO: Autocompletion with all files in the config directory
	-- TODO: Extract config path from vim functions
	local path = CONFIG_PATH .. "lua/" .. opts.args .. ".lua"
	vim.cmd("e " .. path)
end, { nargs = 1 })

-- TODO: Doesn't really work yet
vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', { nargs = 0 })
