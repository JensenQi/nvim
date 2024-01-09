return {
    os.getenv("ghproxy") .. "https://github.com/neoclide/coc.nvim.git",
    branch = "release",
    init = function()
        vim.g.coc_start_at_startup = 1
        vim.g.coc_config_home = '~/.config/nvim/lua/configurations/plugins/coc/'
        vim.g.coc_data_home = "~/.config/nvim/share/coc"
        vim.g.coc_global_extensions = { -- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
            "coc-clangd", "coc-cmake", "coc-clang-format-style-options", "coc-rust-analyzer",
            "coc-html", "coc-css", "coc-tsserver", "coc-vetur", "coc-eslint",
            "coc-java", "coc-go", "coc-golines",
            "coc-sh", "coc-pyright", "coc-sumneko-lua", "coc-vimlsp",
            "coc-toml", "coc-xml", "coc-yaml", "coc-json",
            "coc-sql", "coc-docker", "coc-git"
        }
    end,
    config = function()
        vim.opt.backup = false
        vim.opt.writebackup = false
        vim.opt.updatetime = 300
        vim.opt.signcolumn = "yes"
        vim.fn['coc#config']('sumneko-lua', { enableNvimLuaDev = true })

        local keyset = vim.keymap.set
        local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

        vim.opt.tagfunc = "CocTagFunc"
        function _G.show_docs()
            local cw = vim.fn.expand('<cword>')
            if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
                vim.api.nvim_command('h ' .. cw)
            elseif vim.api.nvim_eval('coc#rpc#ready()') then
                vim.fn.CocActionAsync('doHover')
            else
                vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
            end
        end

        keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
        keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
        keyset("n", "gd", "<C-]>", { silent = true })                                                 -- 跳入定义 define
        keyset("n", "gb", "<C-t>")                                                                    -- 回退 back
        keyset("n", "gu", "<Plug>(coc-references)", { silent = true })                                -- 查看引用(use)
        keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })                            -- 查看实现(Implementation)
        keyset("n", "gc", "<Plug>(coc-type-definition)", { silent = true })                           -- 查看类声明(class)
        keyset("n", "<A-p>", '<CMD>lua _G.show_docs()<CR>', { silent = true })                        -- 文档预览(preview)
        keyset("n", "<A-n>", "<Plug>(coc-diagnostic-next)", { silent = true })                        -- 查看下一个异常(next)
        keyset("n", "<C-A-L>", "<Plug>(coc-format)<CR>", { silent = true })                           --格式化
        keyset("i", "<C-A-L>", "<cmd>CocCommand editor.action.formatDocument<CR>", { silent = true }) --格式化
        keyset("n", "<A-Enter>", "<Plug>(coc-codeaction-cursor)", { silent = true, nowait = true })   -- 修复建议
        keyset("i", "<A-Enter>", "<Plug>(coc-codeaction-cursor)", { silent = true, nowait = true })

        -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
        vim.api.nvim_create_augroup("CocGroup", {})
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "CocGroup",
            command = "silent call CocActionAsync('highlight')",
            desc = "Highlight symbol under cursor on CursorHold"
        })

        -- Setup formatexpr specified filetype(s)
        vim.api.nvim_create_autocmd("FileType", {
            group = "CocGroup",
            pattern = "typescript,json",
            command = "setl formatexpr=CocAction('formatSelected')",
            desc = "Setup formatexpr specified filetype(s)."
        })

        -- Update signature help on jump placeholder
        vim.api.nvim_create_autocmd("User", {
            group = "CocGroup",
            pattern = "CocJumpPlaceholder",
            command = "call CocActionAsync('showSignatureHelp')",
            desc = "Update signature help on jump placeholder"
        })

        -- Apply codeAction to the selected region
        -- Example: `<leader>aap` for current paragraph
        local opts = { silent = true, nowait = true }


        -- Remap keys for apply refactor code actions.
        keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
        keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
        keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
        keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
        keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts) -- Run the Code Lens actions on the current line


        -- Map function and class text objects
        -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
        keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
        keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
        keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
        keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
        keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
        keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
        keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
        keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

        vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
        vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

        -- Add (Neo)Vim's native statusline support
        -- NOTE: Please see `:h coc-status` for integrations with external plugins that
        -- provide custom statusline: lightline.vim, vim-airline
        vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
    end,
    build = "yarn install --frozen-lockfile",
}
