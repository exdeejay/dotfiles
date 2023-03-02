local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1e222a' })
	print 'Cloning packer ..'
	fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.api.nvim_create_autocmd("User", {
		pattern = "PackerComplete",
		callback = function()
			vim.cmd "bw | silent! MasonInstallAll" -- close packer window
			require("packer").loader "nvim-treesitter"
		end,
	})
	vim.cmd "packadd packer.nvim"
	packer_bootstrap = true
end

local packer = require('packer')
packer.init {
	display = {
		working_sym = "ﲊ",
		error_sym = "✗ ",
		done_sym = " ",
		removed_sym = " ",
		moved_sym = "",
		open_fn = function()
			return require("packer.util").float { border = "single" }
		end,
	},
}

packer.startup { require('plugins.list') }

if packer_bootstrap then
	packer.sync()
end

