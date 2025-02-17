return function(keys, func, desc, mode, opts)
    mode = mode or 'n'
    opts = opts or {}

    opts = vim.tbl_extend('force', { desc = desc }, opts)
    vim.keymap.set(mode, keys, func, opts)
end
