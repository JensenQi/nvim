-- 自动补全插件
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

return {
    os.getenv("ghproxy") .. "https://github.com/neoclide/coc.nvim.git",
    branch = "release",
    dependencies = { os.getenv("ghproxy") .. "https://github.com/honza/vim-snippets.git" },
    init = function()
        vim.g.coc_start_at_startup = 1
        vim.g.coc_config_home = '~/.config/nvim/lua/configurations/plugins/coc/'
        vim.g.coc_data_home = "~/.config/nvim/share/coc"
        vim.g.coc_global_extensions = { -- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
            "coc-clangd", "coc-cmake", "coc-clang-format-style-options", "coc-rust-analyzer",
            "coc-html", "coc-css", "coc-tsserver", "coc-vetur", "coc-eslint",
            "coc-java", "coc-go", "coc-golines", "coc-metals",
            "coc-sh", "coc-pyright", "coc-sumneko-lua", "coc-vimlsp",
            "coc-toml", "coc-xml", "coc-yaml", "coc-json",
            "coc-sql", "coc-docker", "coc-git", "coc-snippets", "coc-yank"
        }
    end,
    config = function()
        vim.fn['coc#config']('metals', {
            -- 因为需要用绝对路径，因此放到 lua 中处理而不直接放到 settings.json
            mavenScript = os.getenv("NVIM_HOME") .. "/share/maven/bin/mvn"
        })

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

        vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
    end,
    build = "yarn install --frozen-lockfile",
}
