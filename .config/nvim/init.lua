-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		"ThePrimeagen/vim-be-good",
		"neoclide/coc.nvim",
		"dhananjaylatkar/cscope_maps.nvim",
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.8',
			-- or                              , branch = '0.1.x',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		{
			"kylechui/nvim-surround",
			version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end
		}
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
require("cscope_maps").setup()

vim.cmd([[inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]])
vim.cmd([[set background=dark]])
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[set mouse=a]])

vim.cmd([[set expandtab]])
vim.cmd([[set shiftwidth=4]])
vim.cmd([[set list]])
vim.cmd([[set listchars=tab:>-]])

vim.cmd([[syntax on]])
vim.cmd([[set number]])
vim.cmd([[set number relativenumber]])
vim.cmd([[set nu rnu]])

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- init.lua or inside lua config file
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
-- NOTE: <C-;> is not recognized by most terminals.
-- Instead, map ';' directly without Ctrl (optional)
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true }) -- or pick another convenient key

