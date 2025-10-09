local map = require('custom.mappings.map')

return {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

    {
        "jiaoshijie/undotree",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = { -- load the plugin only when using it's keybinding:
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },

    {
        "mfussenegger/nvim-jdtls",
        config = function() end,
    },

    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gitsigns = require 'gitsigns'

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal { ']c', bang = true }
                    else
                        gitsigns.nav_hunk 'next'
                    end
                end, { desc = 'Jump to next git [c]hange' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal { '[c', bang = true }
                    else
                        gitsigns.nav_hunk 'prev'
                    end
                end, { desc = 'Jump to previous git [c]hange' })

                -- Actions
                -- visual mode
                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'git [s]tage hunk' })
                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'git [r]eset hunk' })
                -- normal mode
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
                map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
                map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
                map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
                map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
                map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
                map('n', '<leader>hD', function()
                    gitsigns.diffthis '@'
                end, { desc = 'git [D]iff against last commit' })
                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
                map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
            end,
        },
    },

    {                       -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts = {
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.opt.timeoutlen
            delay = 0,
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ',
                    Down = '<Down> ',
                    Left = '<Left> ',
                    Right = '<Right> ',
                    C = '<C-…> ',
                    M = '<M-…> ',
                    D = '<D-…> ',
                    S = '<S-…> ',
                    CR = '<CR> ',
                    Esc = '<Esc> ',
                    ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ',
                    NL = '<NL> ',
                    BS = '<BS> ',
                    Space = '<Space> ',
                    Tab = '<Tab> ',
                    F1 = '<F1>',
                    F2 = '<F2>',
                    F3 = '<F3>',
                    F4 = '<F4>',
                    F5 = '<F5>',
                    F6 = '<F6>',
                    F7 = '<F7>',
                    F8 = '<F8>',
                    F9 = '<F9>',
                    F10 = '<F10>',
                    F11 = '<F11>',
                    F12 = '<F12>',
                },
            },

            -- -- Document existing key chains
            -- spec = {
            --     { '<leader>c', group = '[C]ode',     mode = { 'n', 'x' } },
            --     { '<leader>d', group = '[D]ocument' },
            --     { '<leader>r', group = '[R]ename' },
            --     { '<leader>s', group = '[S]earch' },
            --     { '<leader>w', group = '[W]orkspace' },
            --     { '<leader>t', group = '[T]oggle' },
            --     { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
            -- },
        },
    },

    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },

            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "-L",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                },

                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                -- defaults = {
                --   mappings = {
                --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                --   },
                -- },
                -- pickers = {}
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
        end,
    },

    -- LSP Plugins
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },

    {
        "folke/trouble.nvim",
        opts = {
            focus = true,
            auto_close = true,
            -- auto_open = true,
            warn_no_results = false,
            win = {
                position = "right",
                size = 0.5,
            }
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>l",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            -- {
            --     "<leader>xX",
            --     "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            --     desc = "Buffer Diagnostics (Trouble)",
            -- },
            -- {
            --     "<leader>cs",
            --     "<cmd>Trouble symbols toggle focus=false<cr>",
            --     desc = "Symbols (Trouble)",
            -- },
            -- {
            --     "<leader>cl",
            --     "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            --     desc = "LSP Definitions / references / ... (Trouble)",
            -- },
            -- {
            --     "<leader>xL",
            --     "<cmd>Trouble loclist toggle<cr>",
            --     desc = "Location List (Trouble)",
            -- },
            -- {
            --     "<leader>xQ",
            --     "<cmd>Trouble qflist toggle<cr>",
            --     desc = "Quickfix List (Trouble)",
            -- },
        },
    },

    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', opts = {} },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim',       opts = {} },

            -- Allows extra capabilities provided by nvim-cmp
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- TODO this is probably redundant
            vim.lsp.config("gdscript", {})

            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    -- In this case, we create a function that lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                    map('<leader>ra', vim.lsp.buf.rename, '[R]en[a]me')
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight',
                            { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            -- Change diagnostic symbols in the sign column (gutter)
            if vim.g.have_nerd_font then
                -- Change icons for error/warn/etc.
                local signs = { ERROR = '💩', WARN = '🤓', INFO = '󰋼', HINT = '💡' }
                local diagnostic_signs = {}
                for type, icon in pairs(signs) do
                    diagnostic_signs[vim.diagnostic.severity[type]] = icon
                end
                vim.diagnostic.config { signs = { text = diagnostic_signs } }
            end

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            local servers = {
                html = {},
                cssls = {},
                -- ts_ls = {},
                jsonls = {},

                bashls = {},

                pyright = {},

                zls = {},
                clangd = {},

                jdtls = {},
                omnisharp = {},

                intelephense = {},

                marksman = {},
                gdtoolkit = {},

                gopls = {},
                rust_analyzer = {},

                lua_ls = {
                    -- cmd = { ... },
                    -- filetypes = { ... },
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
            }

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                -- lua stuff
                'lua-language-server',
                'stylua',

                -- python stuff
                'blue',
                'ansible-language-server',
                'ansible-lint',
                'pyright',
                -- "python-lsp-server",

                -- web dev stuff
                'css-lsp',
                'html-lsp',
                -- 'typescript-language-server',
                'vue-language-server',
                -- 'deno',
                'prettier',
                'prettierd',

                -- c/cpp stuff
                'clangd',
                'clang-format',

                -- bash stuff
                'bash-language-server',
                'beautysh',
                'shellcheck',

                -- blazingly fast :rocket:
                -- "rust-analyzer",

                -- other stuff
                -- 'efm',
                'gdtoolkit',
                'jdtls',
                'omnisharp',
                'zls',
                -- 'nginx-language-server',
                'intelephense',
                'php-cs-fixer',
                'marksman',
            })

            require('mason-tool-installer').setup { ensure_installed }

            require('mason-lspconfig').setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        vim.lsp.config(server_name, server)
                    end,

                },

                -- thank you @tigion https://github.com/mason-org/mason-lspconfig.nvim/issues/587
                -- FIX: Workaround for mason-lspconfig errors with
                --      the new `vue_ls` config in nvim-lspconfig.
                --
                -- - https://github.com/neovim/nvim-lspconfig/commit/85379d02d3bac8dc68129a4b81d7dbd00c8b0f77
                --
                -- Don't start with `vue_ls` config from mason-lspconfig,
                -- instead start directly with `vim.lsp.enable`.
                --
                automatic_enable = { exclude = { 'vue_ls' } },
                vim.lsp.enable({ 'vue_ls' }),
            }

            -- won't do anything if i put this in the servers table,
            -- but it works fine when manually called like this. ????
            vim.lsp.config("jsonnet_ls", {
                settings = {
                    -- ext_vars = {
                    --     foo = 'bar',
                    -- },
                    formatting = {
                        -- Indent = 4,

                        -- default values
                        -- MaxBlankLines       = 2,
                        -- StringStyle         = 'single',
                        -- CommentStyle        = 'slash',
                        -- PrettyFieldNames    = true,
                        -- PadArrays           = false,
                        -- PadObjects          = true,
                        -- SortImports         = true,
                        -- UseImplicitPlus     = true,
                        -- StripEverything     = false,
                        -- StripComments       = false,
                        -- StripAllButComments = false,
                    },
                },
            })


            -- FUCK OFF!!!!!!!!!!!!!
            vim.lsp.config("vtsls", {
                filetypes = { 'vue', 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    location = vim.fn.stdpath('data') ..
                                        "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                                    languages = { 'vue' },
                                    configNamespace = 'typescript',
                                }
                            },
                        },
                    },
                },
            })
        end,
    },


    --------------------------------------------------------------------------------
    -- Cellular Automaton: Give up? Run this and go for a walk!
    --------------------------------------------------------------------------------

    {
        'Eandrju/cellular-automaton.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        keys = {
            { '<Leader><Leader>c', ':CellularAutomaton make_it_rain<CR>' },
        },
    },

    { -- Autoformat
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>fm',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = 'Format buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                -- local disable_filetypes = { c = true, cpp = true }
                local disable_filetypes = {}
                local lsp_format_opt
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    lsp_format_opt = 'never'
                else
                    lsp_format_opt = 'fallback'
                end
                return {
                    timeout_ms = 500,
                    lsp_format = lsp_format_opt,
                }
            end,

            -- note to future self: most formatters seemed to already work when this table was empty
            -- i only added prettier for markdown because it wasn't doing anything
            -- only add stuff here if they don't already work
            formatters_by_ft = {
                vue = { 'prettier' },
                html = { 'prettier' },
                css = { 'prettier' },

                json = { 'prettier' },

                markdown = { 'prettier' },

                -- lua = { 'stylua' },
                -- Conform can also run multiple formatters sequentially
                -- python = { "isort", "black" },
                --
                -- You can use 'stop_after_first' to run the first available formatter from the list
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },

            formatters = {
                prettier = {
                    -- only use prettier if there's a prettier config file or package.json entry
                    -- require_cwd = true,

                    prepend_args = { "--tab-width", "4" },
                },
            }
        },
    },

    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        config = function()
            -- See `:help cmp`
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert {
                    -- Select the [n]ext item
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ['<C-p>'] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<C-y>'] = cmp.mapping.confirm { select = true },

                    -- If you prefer more traditional completion keymaps,
                    -- you can uncomment the following lines
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ['<C-Space>'] = cmp.mapping.complete {},

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                },
                sources = {
                    {
                        name = 'lazydev',
                        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                        group_index = 0,
                    },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
            }
        end,
    },

    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            vim.cmd.colorscheme 'catppuccin'

            -- You can configure highlights by doing something like:
            vim.cmd.hi 'Comment gui=none'
        end,
    },

    -- Highlight todo, notes, etc in comments
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    { -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        dependencies = {
            'Lamby777/timewasted.nvim',
        },

        config = function()
            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require 'mini.statusline'
            statusline.setup {
                use_icons = vim.g.have_nerd_font,
                -- HOW TF DO YOU GET THIS TO WORKKKKKKKK THERE ARE LIKE 0 GOOD EXAMPLES ONLINE
                --
                -- content = {
                --     active = function()
                --         local diag_signs    = { ERROR = '!', WARN = '?', INFO = '@', HINT = '*' }
                --
                --         local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                --         local git           = MiniStatusline.section_git({ trunc_width = 40 })
                --         local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
                --         local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75, signs = diag_signs })
                --         local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
                --         -- local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
                --         local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                --         local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
                --
                --         local location      = function() return 'Line %2l Col %-2v' end
                --         local twc           = function() return require('timewasted').get_fmt() end
                --
                --         return MiniStatusline.combine_groups({
                --             { hl = mode_hl,                 strings = { mode } },
                --             { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                --
                --             '%<', -- Mark general truncate point
                --             -- { hl = 'MiniStatuslineFilename', strings = { filename } },
                --             { hl = 'MiniStatuslineFilename', strings = { twc } },
                --
                --             '%=', -- End left alignment
                --             { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                --             { hl = mode_hl,                  strings = { search, location } },
                --         })
                --     end
                -- }
            }

            -- You can configure sections in the statusline by overriding their
            -- default behavior.
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return 'Line %2l Col %-2v | ' .. require('timewasted').get_fmt() .. ' '
            end
        end,
    },

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs', -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'css',
                'diff',
                'dockerfile',
                'html',
                'javascript',
                'json',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'rust',
                'toml',
                'tsx',
                'typescript',
                'vim',
                'vimdoc',
                'vue',
                'yaml',
                'zig',
            },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,

                disable = { 'csv' },

                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
    },

    -- require 'kickstart.plugins.debug',

    {
        'nvim-neo-tree/neo-tree.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
        cmd = 'Neotree',
        keys = {
            { '<C-n>', ':Neotree toggle<CR>', desc = 'NeoTree reveal', silent = true },
        },
        opts = {
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
                window = {
                    mappings = {
                        ["I"] = "toggle_hidden",
                    },
                },
            },
            window = {
                mappings = {
                    ["W"] = "close_all_nodes",
                    ["z"] = "",
                },
            },
        },
    },

    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        -- Optional dependency
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('nvim-autopairs').setup {}
            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            local cmp = require 'cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },

    -- { -- Linting
    --     'mfussenegger/nvim-lint',
    --     event = { 'BufReadPre', 'BufNewFile' },
    --     config = function()
    --         local lint = require 'lint'
    --         lint.linters_by_ft = {
    --             markdown = { 'markdownlint' },
    --         }
    --
    --         -- To allow other plugins to add linters to require('lint').linters_by_ft,
    --         -- instead set linters_by_ft like this:
    --         -- lint.linters_by_ft = lint.linters_by_ft or {}
    --         -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    --         --
    --         -- However, note that this will enable a set of default linters,
    --         -- which will cause errors unless these tools are available:
    --         -- {
    --         --   clojure = { "clj-kondo" },
    --         --   dockerfile = { "hadolint" },
    --         --   inko = { "inko" },
    --         --   janet = { "janet" },
    --         --   json = { "jsonlint" },
    --         --   markdown = { "vale" },
    --         --   rst = { "vale" },
    --         --   ruby = { "ruby" },
    --         --   terraform = { "tflint" },
    --         --   text = { "vale" }
    --         -- }
    --         --
    --         -- You can disable the default linters by setting their filetypes to nil:
    --         -- lint.linters_by_ft['clojure'] = nil
    --         -- lint.linters_by_ft['dockerfile'] = nil
    --         -- lint.linters_by_ft['inko'] = nil
    --         -- lint.linters_by_ft['janet'] = nil
    --         -- lint.linters_by_ft['json'] = nil
    --         -- lint.linters_by_ft['markdown'] = nil
    --         -- lint.linters_by_ft['rst'] = nil
    --         -- lint.linters_by_ft['ruby'] = nil
    --         -- lint.linters_by_ft['terraform'] = nil
    --         -- lint.linters_by_ft['text'] = nil
    --
    --         -- Create autocommand which carries out the actual linting
    --         -- on the specified events.
    --         local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    --         vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    --             group = lint_augroup,
    --             callback = function()
    --                 -- Only run the linter in buffers that you can modify in order to
    --                 -- avoid superfluous noise, notably within the handy LSP pop-ups that
    --                 -- describe the hovered symbol using Markdown.
    --                 if vim.opt_local.modifiable:get() then
    --                     lint.try_lint()
    --                 end
    --             end,
    --         })
    --     end,
    -- },

    { -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        opts = {},
    },

    -------------------------------------
    -------------------------------------
    -------------------------------------
    -------------------------------------
    -- STUFF ADDED FROM THE OLD CONFIG --
    -- If anything breaks, check here! --
    -------------------------------------
    -------------------------------------
    -------------------------------------
    -------------------------------------

    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },

    {
        'TamaMcGlinn/quickfixdd',
    },

    {
        'ellisonleao/dotenv.nvim',
        opts = {},
    },

    {
        'akinsho/git-conflict.nvim',
        version = '*',
        config = true,
    },

    {
        'Lamby777/timewasted.nvim',
        config = function()
            local tw = require 'timewasted'

            tw.setup {
                time_formatter = function(total_sec)
                    local d, h, m, _ = unpack(tw.dhms(total_sec))
                    -- local time_str = string.format('% 4dd %02dh %02dm %02ds', d, h, m, s)
                    local time_str = string.format('% 4dd %02dh %02dm', d, h, m)

                    return string.format('TWC: %s', time_str)
                end,
            }
        end,
    },

    {
        'Lamby777/presence.nvim',
        branch = 'main',
        config = function()
            -- The setup config table shows all available config options with their default values:
            require('presence').setup {
                -- General options
                neovim_image_text = 'i use neovim btw 🤓',
                blacklist_repos = {
                    -- hmm... :3
                    'npxTSC/god',
                    'Lamby777/days-since',
                    'Tea-Client',
                },

                editing_text = 'Adding bugs to `%s`',
                file_explorer_text = 'Browsing `%s`',
                git_commit_text = 'Force-pushing to master',
                reading_text = 'Staring at `%s`',
                workspace_text = '(Not) Working on `%s`',

                client_id = '793271441293967371',
                -- line_number_text    = "Line %s out of %s",
                -- auto_update         = true,
                -- main_image          = "neovim",
                -- client_id           = "1172122807501594644",
                -- log_level           = nil,
                -- debounce_timeout    = 10,
                -- enable_line_number  = false,
                -- blacklist           = {},
                -- buttons             = true,
                -- file_assets         = {},
                -- show_time           = true,

                -- Rich Presence text options
                -- plugin_manager_text = "Managing plugins",
            }
        end,
    },

    -- {
    --   "folke/zen-mode.nvim",
    --   opts = {
    --     -- your configuration comes here
    --     -- or leave it empty to use the default settings
    --     -- refer to the configuration section below
    --   },
    -- },

    { 'tpope/vim-repeat' },

    { 'tpope/vim-unimpaired' },

    { 'dahu/vim-fanfingtastic' },

    {
        'cameron-wags/rainbow_csv.nvim',
        config = true,
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon',
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim',
        },
    },

    {
        'rmagatti/auto-session',
        opts = {
            log_level = 'error',
            suppressed_dirs = { "~/Downloads" },
        }
    },

    -- { 'folke/neodev.nvim', opts = {} },

    {
        'NvChad/base46',
        branch = 'v2.0',
        build = function()
            require('base46').load_all_highlights()
        end,
    },

    {
        'Lamby777/nvterm',
        opts = {},
    },

    {
        "famiu/bufdelete.nvim",
    },

    {
        "willothy/nvim-cokeline",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "stevearc/resession.nvim"
        },
        config = true,

        -- https://github.com/willothy/nvim-cokeline#wrench-configuration
        opts = {
            show_if_buffers_are_at_least = 0,

            buffers = {
                focus_on_delete = 'prev',
            },

            history = {
                enabled = false,
            },

            -- default: https://github.com/willothy/nvim-cokeline/blob/main/lua/cokeline/config.lua
            components = {
                {
                    text = function(buffer) return "  " .. buffer.devicon.icon end,
                    fg = function(buffer) return buffer.devicon.color end,
                },
                {
                    text = function(buffer) return buffer.unique_prefix end,
                    fg = function()
                        return
                            require("cokeline.hlgroups")
                            .get_hl_attr("Comment", "fg")
                    end,
                    italic = true,
                },
                {
                    text = function(buffer) return buffer.filename end,
                    underline = function(buffer)
                        if buffer.is_hovered and not buffer.is_focused then
                            return true
                        end
                    end,
                },
                {
                    text = function(buffer)
                        return "    " .. (buffer.is_modified and "" or " ") .. "  "
                    end,
                },
            },
        },

        -- middle_mouse_command = 'Bdelete! %d',
    },

    {
        'numToStr/Comment.nvim',
    },

    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
        ft = {
            "csv",
            "tsv",
            "csv_semicolon",
            "csv_whitespace",
            "csv_pipe",
            "rfc_csv",
            "rfc_semicolon",
        },
        cmd = {
            "RainbowDelim",
            "RainbowDelimSimple",
            "RainbowDelimQuoted",
            "RainbowMultiDelim",
        },
    },
}
