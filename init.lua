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
local plugins = {
  { 'AlexvZyl/nordic.nvim' },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { 'neovim/nvim-lspconfig' },
}
require("lazy").setup(plugins)

local language_servers = { 'lua_ls' }

-- install LSPs with Mason
require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = language_servers,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

for _, ls in ipairs(language_servers) do
	require('lspconfig')[ls].setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = { globals = { 'vim' } }
			}
		}
		-- you can add other fields for setting up lsp server in this table
	})
end

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
