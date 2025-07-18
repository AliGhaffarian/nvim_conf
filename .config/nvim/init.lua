-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.cmd([[
  nnoremap <silent> K :call ShowDocumentation()<CR>
  " Show hover when provider exists, fallback to vim's builtin behavior.
  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('definitionHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
]])
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	  "ervandew/supertab",
	  "ThePrimeagen/vim-be-good",
	  "neoclide/coc.nvim",
	  "tpope/vim-surround",
	  "nvim-lua/plenary.nvim",
	  "nvim-telescope/telescope.nvim",
          "nvim-treesitter/nvim-treesitter",
	  "dhananjaylatkar/cscope_maps.nvim",
	  "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
	  "echasnovski/mini.pick", -- optional [for picker="mini-pick"]
	  "folke/snacks.nvim", -- optional [for picker="snacks"]
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


vim.cmd([[syntax on]])
vim.cmd([[set number]])
vim.cmd([[set number relativenumber]])
vim.cmd([[set nu rnu]])


vim.keymap.set('n', '<C-n>', vim.cmd.bnext, { desc = 'bnext' })
vim.keymap.set('n', '<C-m>', vim.cmd.bprev, { desc = 'bprev' })

--telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
