local o = vim.opt

-- show line numbers
o.number = true
o.numberwidth = 2
o.ruler = false
-- o.relativenumber = true

o.mouse = 'a' -- allow using mouse

-- Indenting
o.autoindent = true
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4
o.fillchars = { eob = ' ' }

o.shortmess:append 'sI' -- disable nvim intro

o.termguicolors = true
o.laststatus = 3 -- global statusline

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
o.whichwrap:append '<>[]hl'

-- Don't show the mode, since it's already in the status line
o.showmode = false

vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

o.signcolumn = 'yes' -- Keep signcolumn on by default
o.updatetime = 250 -- Decrease update time
o.timeoutlen = 300 -- Decrease mapped sequence wait time

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'` and `:help 'listchars'`
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.inccommand = 'split' -- Preview substitutions live, as you type!
o.cursorline = true -- Show which line your cursor is on
o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
