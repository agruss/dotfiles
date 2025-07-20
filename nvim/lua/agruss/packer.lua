local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-tree/nvim-web-devicons'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({ 
	  "folke/tokyonight.nvim",
	  as = "tokyonight",
	  config = function()
		  vim.cmd('colorscheme tokyonight')
	  end
  })
  use('nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})

  use { 'akinsho/bufferline.nvim', tag = 'v4.9.1',  requires = 'nvim-tree/nvim-web-devicons' }

  use ({ 'kylechui/nvim-surround', tag = 'v3.1.0', config = function()
      require('nvim-surround').setup({}) end })

  use { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons'  } }

  use { 'lewis6991/gitsigns.nvim' }

  use { 'tpope/vim-fugitive' }

  use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }

  use { 'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    config = function()
        require('render-markdown').setup({
            completions = { lsp = { enabled = true } }
        })
    end}

  -- LSP setup

  use 'neovim/nvim-lspconfig'

  use { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' }

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  use 'seblyng/roslyn.nvim'

  -- Helm detection
  use 'towolf/vim-helm'

  use ({
      'stevearc/conform.nvim',
      config = function()
          require('conform').setup()
      end
  })

  -- debugging setup
  use 'mfussenegger/nvim-dap'
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } }

  if packer_bootstrap then
      require('packer').sync()
  end
end)
