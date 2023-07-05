--- bootstrap plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

--- load plugins
plugins = {
  { 'AlexvZyl/nordic.nvim' },
  { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" }
}
require("lazy").setup(plugins)

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "eex",
    "elixir",
    "erlang",
    "heex",
    "html"
  },
  highlight = { enable = true},
}

--- somehow, this stops Nvim from adding a tab
--- when it autoindents a line
--= in addition to the spaces its copying from the above line
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

--- set line numbers for pairing
vim.opt.number = true

--- enable 24-bit RGB colors
vim.opt.termguicolors = true

--- set the colorscheme
vim.cmd("colorscheme nordic")
