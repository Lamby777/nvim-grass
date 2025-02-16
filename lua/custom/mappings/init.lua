-- n, v, i, o, t = mode names

local XDG_OPEN_COPIED = '<cmd>!xdg-open <c-r>" &<cr><cr>'

local map = function(keys, func, desc, mode, opts)
  mode = mode or 'n'
  opts = opts or {}

  opts = vim.tbl_extend('force', { desc = desc }, opts)
  vim.keymap.set(mode, keys, func, opts)
end

-- Diagnostic keymaps
map('q', 'b', 'Back (b)', { 'o', 'n', 'v' }, { remap = false })
map('Q', 'B', 'Back (B)', { 'o', 'n', 'v' }, { remap = false })
map(';', ':', 'Command')
map('<leader>o', '<cmd>qa<CR>', 'Quit All', { 'n', 'v' })
map('<leader>O', '<cmd>qa!<CR>', 'Force Quit All', { 'n', 'v' })
map('<leader>q', 'q', 'Record', { 'n', 'v' })
map('<C-s>', '<cmd>w<CR>', 'CTRL + S to Save', { 'n', 'v' })

-- Normal mode mappings
map('gt', XDG_OPEN_COPIED, 'Open Link (from clipboard)', nil, { nowait = true })
map('gx', 'yiW' .. XDG_OPEN_COPIED, 'Open Link (from iW)', nil, { nowait = true })
map('<F1>', '<Esc>', 'F1 Escape', nil, { nowait = true, noremap = true })

map('<leader>tt', '<cmd>term<cr><cmd>set nonumber<cr>i', 'New Terminal Tab', nil, { nowait = true })
map('<leader>bb', '<cmd> enew <CR>', 'New Buffer', nil, { nowait = true })

map('<leader>tw', '"lx"lph', 'Swap with letter after', nil, { nowait = true })
map('<leader>hl', '<cmd>Telescope highlights<cr>', 'Treesitter highlights', nil, { nowait = true })
map('<leader>bl', 'i<cr><Esc>', 'Break line', nil, { nowait = true })
map('<leader>ba', 'a<cr><Esc>', 'Break line after', nil, { nowait = true })
map('<leader>cb', 'o```<cr><cr>```<Esc>kk$a', 'Code Block (3 backticks)', nil, { nowait = true })
map('<leader>cl', 'S<Esc>', 'Clear Line', nil, { nowait = true })

-- Insert mode mappings
map('<F1>', '<Esc>', 'F1 Escape', { 'i' }, { nowait = true, noremap = true })

-- Visual mode mappings
map('<leader>re', 'c<C-O>:set ri<CR><C-R>"<Esc>:set nori<CR>', 'Reverse Selection', { 'v' }, { nowait = true, noremap = true })

-- Terminal mode mappings
map('<Esc>', '<C-\\><C-n>', 'Escape Terminal', { 't' }, { silent = true })

-- Window navigation
map('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

-- Bufferline
map('<Tab>', '<cmd>BufferLineCycleNext<CR>', 'Next Tab')
map('<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', 'Prev Tab')
map('<leader>x', '<cmd>bd<CR>', 'Close Tab')

-- Comment toggling
map('<leader>/', function()
  require('Comment.api').toggle.linewise.current()
end, 'Toggle comment')

map('<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", 'Toggle comment', { 'v' })

-- Remap backslash to ; and , for convenience
map('\\|', '<Plug>fanfingtastic_;', '')
map('\\', '<Plug>fanfingtastic_,', '')

-- Unimpaired maps
map('<M-k>', '[e', 'Move line up')
map('<M-j>', ']e', 'Move line down')
map('<M-k>', '[egv', 'Move selected line(s) up', { 'v' })
map('<M-j>', ']egv', 'Move selected line(s) down', { 'v' })

-- stuff from nvchad built-in mappings
-- Insert mode mappings
map('<C-b>', '<ESC>^i', 'Beginning of line', { 'i' })
map('<C-e>', '<End>', 'End of line', { 'i' })

-- Navigate within insert mode
map('<C-h>', '<Left>', 'Move left', { 'i' })
map('<C-l>', '<Right>', 'Move right', { 'i' })
map('<C-j>', '<Down>', 'Move down', { 'i' })
map('<C-k>', '<Up>', 'Move up', { 'i' })

-- Normal mode mappings
map('<Esc>', '<cmd>noh<CR>', 'Clear highlights')
map('<C-h>', '<C-w>h', 'Window left')
map('<C-l>', '<C-w>l', 'Window right')
map('<C-j>', '<C-w>j', 'Window down')
map('<C-k>', '<C-w>k', 'Window up')
map('<C-s>', '<cmd>w<CR>', 'Save file')
map('<C-c>', '<cmd>%y+<CR>', 'Copy whole file')
map('<leader>n>', '<cmd>set nu!<CR>', 'Toggle line number')
map('<leader>rn>', '<cmd>set rnu!<CR>', 'Toggle relative number')

-- Buffers and cheatsheet
map('<leader>b', '<cmd>enew<CR>', 'New buffer')
map('<leader>ch', '<cmd>NvCheatsheet<CR>', 'Mapping cheatsheet')

-- LSP formatting
map('<leader>fm', function()
  vim.lsp.buf.format { async = true }
end, 'LSP formatting')

-- Terminal mode escape
map('<C-x>', vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true), 'Escape terminal mode', { 't' })

-- Visual mode mappings
map('<', '<gv', 'Indent line', { 'v' })
map('>', '>gv', 'Indent line', { 'v' })

-- Visual block mode (x-mode) mappings
map('p', 'p:let @+=@0<CR>:let @"=@0<CR>', "Don't copy replaced text", { 'x' })

-- nvterm stuff
-- Terminal mode mappings
map('<A-i>', function()
  require('nvterm.terminal').toggle 'float'
end, 'Toggle floating term', { 't' })

map('<A-h>', function()
  require('nvterm.terminal').toggle 'horizontal'
end, 'Toggle horizontal term', { 't' })

map('<A-v>', function()
  require('nvterm.terminal').toggle 'vertical'
end, 'Toggle vertical term', { 't' })

-- Normal mode mappings
map('<A-i>', function()
  require('nvterm.terminal').toggle 'float'
end, 'Toggle floating term')

map('<A-h>', function()
  require('nvterm.terminal').toggle 'horizontal'
end, 'Toggle horizontal term')

map('<A-v>', function()
  require('nvterm.terminal').toggle 'vertical'
end, 'Toggle vertical term')

-- Create new terminals
map('<leader>h', function()
  require('nvterm.terminal').new 'horizontal'
end, 'New horizontal term')

map('<leader>v', function()
  require('nvterm.terminal').new 'vertical'
end, 'New vertical term')

-- TODO change these into vim.keymap.set later
vim.cmd [[
    " break at word boundaries, not characters
    :set formatoptions=l
    :set lbr

    " A command to double all indentation in the file:
    function! DIndent()
        :%s/^\s*/&&
        :nohl
    endfunction

    command! -nargs=0 DIndent call DIndent()
]]

-- vim.keymap.set('t', '<C-x>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
