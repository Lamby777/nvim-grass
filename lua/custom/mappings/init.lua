-- n, v, i, o, t = mode names

local XDG_OPEN_COPIED = '<cmd>!xdg-open <c-r>" &<cr><cr>'

local map = require('custom.mappings.map')

-- Unimpaired line movement maps
map('<M-k>', '[e', 'Move line up', nil, { remap = true })
map('<M-j>', ']e', 'Move line down', nil, { remap = true })
map('<M-k>', '[egv', 'Move selected line(s) up', { 'v' }, { remap = true })
map('<M-j>', ']egv', 'Move selected line(s) down', { 'v' }, { remap = true })

-- Diagnostic keymaps
map('q', 'b', 'Back (b)', { 'o', 'n', 'v' })
map('Q', 'B', 'Back (B)', { 'o', 'n', 'v' })
map(';', ':', 'Command')
map('<leader>o', '<cmd>qa<CR>', 'Quit All', { 'n', 'v' })
map('<leader>O', '<cmd>qa!<CR>', 'Force Quit All', { 'n', 'v' })
map('<leader>q', 'q', 'Record', { 'n', 'v' })
map('<C-s>', '<cmd>w<CR>', 'CTRL + S to Save', { 'n', 'v' })

-- Normal mode mappings
map('gt', XDG_OPEN_COPIED, 'Open Link (from clipboard)', nil, { nowait = true })
map('gx', 'yiW' .. XDG_OPEN_COPIED, 'Open Link (from iW)', nil, { nowait = true })
map('<F1>', '<Esc>', 'F1 Escape', { 'n', 'i' }, { nowait = true, noremap = true })

map('<leader>tt', '<cmd>term<cr><cmd>set nonumber<cr>i', 'New Terminal Tab', nil, { nowait = true })
map('<leader>bb', '<cmd>enew<CR>', 'New Buffer', nil, { nowait = true })

map('<leader>tw', 'xp', 'Swap with letter after', nil, { nowait = true })
map('<leader>bl', 'i<cr><Esc>', 'Break line', nil, { nowait = true })
map('<leader>ba', 'a<cr><Esc>', 'Break line after', nil, { nowait = true })
map('<leader>cb', 'o```<cr><cr>```<Esc>kk$a', 'Code Block (3 backticks)', nil, { nowait = true })
map('<leader>cl', 'S<Esc>', 'Clear Line', nil, { nowait = true })

-- in a far and distant galaxy, inside my `:Telescope` i see,
-- a pair of eyes peek back at me, -- he walks and talks and looks like me.
-- sits around inside his house, from room to room, he moves about,
-- fills his life with pointless things, and wonders how it all turns out...
-- doodoodoo doo doo, doodoodoo doo doo 🎵🎵🎵
map('<leader>cm', '<cmd>Telescope git_commits<CR>', 'Git commits', nil, { nowait = true })
map('<leader>gs', '<cmd>Telescope git_status<CR>', 'Git status', nil, { nowait = true })
map('<leader>pt', '<cmd>Telescope terms<CR>', 'Pick hidden term', nil, { nowait = true })
map('<leader>th', '<cmd>Telescope themes<CR>', 'Search nvim themes', nil, { nowait = true })
map('<leader>ma', '<cmd>Telescope marks<CR>', 'telescope bookmarks', nil, { nowait = true })

map('<leader>hl', '<cmd>Telescope highlights<cr>', 'Treesitter highlights', nil, { nowait = true })
map('<leader>ff', '<cmd> Telescope find_files <CR>', 'Find files', nil, { nowait = true })
map('<leader>fa', '<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>', 'Find all', nil,
    { nowait = true })
map('<leader>fw', '<cmd> Telescope live_grep <CR>', 'Live grep', nil, { nowait = true })
map('<leader>fb', '<cmd> Telescope buffers <CR>', 'Find buffers', nil, { nowait = true })
map('<leader>fh', '<cmd> Telescope help_tags <CR>', 'Help page', nil, { nowait = true })
map('<leader>fo', '<cmd> Telescope oldfiles <CR>', 'Find oldfiles', nil, { nowait = true })
map('<leader>fz', '<cmd> Telescope current_buffer_fuzzy_find <CR>', 'Find in current buffer', nil, { nowait = true })

-- git stuff
map('<leader>rh', '<cmd>Gitsigns reset_hunk<CR>', 'Reset hunk')
map('<leader>gb', '<cmd>Gitsigns blame_line<CR>', 'Blame line')
map('<leader>td', '<cmd>Gitsigns toggle_deleted<CR>', 'Toggle deleted')


-- Visual mode mappings
map('<leader>re', 'c<C-O>:set ri<CR><C-R>"<Esc>:set nori<CR>', 'Reverse Selection', { 'v' },
    { nowait = true, noremap = true })

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
map('<leader><Tab>', '<cmd>BufferLineMoveNext<CR>', 'Move Tab Right')
map('<leader><S-Tab>', '<cmd>BufferLineMovePrev<CR>', 'Move Tab Left')
map('<leader>x', '<cmd>bd<CR>', 'Close Tab')
map('<leader>X', '<cmd>bd!<CR>', 'Close Tab (Force)')

-- Comment toggling
map('<leader>/', function()
    require('Comment.api').toggle.linewise.current()
end, 'Toggle comment')

map('<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", 'Toggle comment',
    { 'v' })

-- Remap backslash to ; and , for convenience
map('\\|', '<Plug>fanfingtastic_;', '')
map('\\', '<Plug>fanfingtastic_,', '')

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
map('<leader>n', '<cmd>set nu!<CR>', 'Toggle line number')
map('<leader>rn', '<cmd>set rnu!<CR>', 'Toggle relative number')

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
map('<A-i>', function() require('nvterm.terminal').toggle 'float' end, 'Toggle floating term', { 'n', 't' })
map('<A-h>', function() require('nvterm.terminal').toggle 'horizontal' end, 'Toggle horizontal term', { 'n', 't' })
map('<A-v>', function() require('nvterm.terminal').toggle 'vertical' end, 'Toggle vertical term', { 'n', 't' })

-- TODO change these into vim.keymap.set later
vim.cmd [[
    " fmt on save
    autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })

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
