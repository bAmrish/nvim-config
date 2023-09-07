-- require("user.plugins")
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
    {'nvim-lualine/lualine.nvim'},
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

vim.cmd.colorscheme('tokyonight')

--------------------------------------------------------------------------------
-- KEY BINDINGS
--------------------------------------------------------------------------------

-- Save the current file with <leader>w 
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc= 'Save'})


-- Buffer Key Mappings --
-- My own buffer key mappings
vim.keymap.set('n', '<leader>b', '<cmd>:ls<cr>', {desc='Show list of all the open buffers'})

-- open previous buffer
vim.keymap.set('n', '<leader><leader>', '<cmd>:bp<cr>', {desc='switch to previous buffer'})

-- map page up and page down
vim.keymap.set('n', '<leader>j', '<C-d>', {desc='Page down'})
vim.keymap.set('n', '<leader>k', '<C-u>', {desc='Page up'})


require('lualine').setup({
    theme = 'gruvbox',
    icons_enabled = false,
})






















