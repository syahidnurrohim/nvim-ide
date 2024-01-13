if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

-- Session manager
if not vim.fn.has("nvim-0.7.0") then
	require("session_manager.utils").notify("Neovim 0.7+ is required for session manager plugin", vim.log.levels.ERROR)
	return
end

local subcommands = require("session_manager.subcommands")
local session_manager = require("session_manager")

vim.api.nvim_create_user_command(
	"SessionManager",
	subcommands.run,
	{ nargs = 1, bang = true, complete = subcommands.complete, desc = "Run session manager command" }
)

vim.cmd("command! LoadSession SessionManager load_current_dir_session")
vim.cmd("command! SaveSession SessionManager save_current_session")
vim.cmd("command! Q qa")

vim.api.nvim_exec(
	[[
  augroup AfterVimEnter
    autocmd!
    autocmd VimEnter * source ~/.vimrc
  augroup END
]],
	false
)
