-- My own custom init.lua file. 
-- from scratch.

-- Start with mapping you leader key to ' ' (space) 
vim.g.mapleader = ' '

--------------------------------------------------------------------------------
-- PLUGINS
--------------------------------------------------------------------------------

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require('lazy').setup(plugins, lazy.opts)
end


lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup ({
	{'folke/tokyonight.nvim'},
    {'navarasu/onedark.nvim'},
    {'tpope/vim-fugitive'},
	{'nvim-lualine/lualine.nvim'},
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {'kevinhwang91/promise-async'},
    },
	{'numToStr/Comment.nvim'},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {"williamboman/mason.nvim"},
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },
})
  

require('onedark').setup({style = 'darker'})

-- vim.cmd.colorscheme('tokyonight')
vim.cmd.colorscheme('onedark')

require('lualine').setup({
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
})

require('Comment').setup()
require("mason").setup()
local wk = require("which-key")
wk.register(mappings, opts)

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
}
require('ufo').setup({
    close_fold_kinds = {'imports', 'comment'},
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})
--------------------------------------------------------------------------------
-- CUSTOM SETTINGS
--------------------------------------------------------------------------------

local set = vim.opt

-- Set line numbers
set.number = true

-- Set the tab width
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4

-- Controls whether or not Neovim should transform a Tab character to spaces.
set.expandtab = true

-- set autoindent 
set.autoindent = true

-- enable mouse
set.mouse = 'a'

-- ignore case for search
set.ignorecase = true

-- Makes our search ignore uppercase letters 
-- unless the search term has an uppercase letter. 
set.smartcase = true

-- disable the highlighing of the results of the previous search.
set.hlsearch = false

-- Wrap long lines 
set.wrap = true 

-- Set cursorline
set.cursorline = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
set.clipboard = 'unnamedplus'

-- Save undo history
set.undofile = true

-- Keep signcolumn on by default
set.signcolumn = 'yes'

-- There are certain files that we would never want to edit with Vim.
-- will ignore files with these extensions.
set.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- Set the commands to save in history default number is 20.
set.history = 1000

-- auto completion menu after pressing TAB.
set.wildmenu = true

-- Make wildmenu behave like similar to Bash completion.
set.wildmode= "list:longest"

set.termguicolors = true

-- settings for nvim-ufo
-- https://github.com/kevinhwang91/nvim-ufo
set.foldcolumn = '1' -- '0' is not bad
set.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
set.foldlevelstart = 99
set.foldenable = true


--------------------------------------------------------------------------------
-- KEY BINDINGS
--------------------------------------------------------------------------------

-- Save the current file with <leader>w 
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc= '[w]rite the file to disk. Save.'})


-- Buffer Key Mappings --
-- My own buffer key mappings
vim.keymap.set('n', '<leader>b', '<cmd>:ls<cr>', {desc='Show list of all the open [b]uffers'})
-- close and remove the buffer
vim.keymap.set('n', '<leader>q', '<cmd>:bd<cr>', {desc='[q]uit the current active buffer. Closes the buffer'})

-- open previous buffer
vim.keymap.set('n', '<leader><leader>', '<cmd>:bp<cr>', {desc='Switch to previous buffer'})

-- map page up and page down
vim.keymap.set('n', '<leader>j', '<C-d>', {desc='Page down'})
vim.keymap.set('n', '<leader>k', '<C-u>', {desc='Page up'})


-- Configure telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = '[f]ind [f]iles'})
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {desc = '[f]ind [s]ymbols'})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {desc = '[g]it [f]iles'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = '[f]ind [b]uffer'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = '[f]ind [h]elp'})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {desc = '[l]ive [g]rep'})


















