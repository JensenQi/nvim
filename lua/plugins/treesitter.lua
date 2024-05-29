-- 语法分析插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvim-treesitter/nvim-treesitter.git",
        version = "*",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
        config = function()
            -- proxy github
            for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
                config.install_info.url = config.install_info.url:gsub(
                    "https://github.com",
                    os.getenv("ghproxy") .. "https://github.com"
                )
            end

            -- enable code folde
            vim.opt.foldmethod = 'expr' -- enable folding (default 'foldmarker')
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
            vim.opt.foldlevel = 9999    -- open a file fully expanded, set to

            local configs = require("nvim-treesitter.configs")
            configs.setup({
                -- support language
                ensure_installed = { 
                    "c", "cmake", "cpp", "cuda", "llvm", "rust",
                    "groovy", "java", "kotlin", "scala", "go",
                    "css", "html", "javascript", "typescript", "vue",
                    "bash", "lua", "python", "vim", "vimdoc",
                    "hocon", "ini", "json", "proto", "toml", "yaml", "xml",
                    "dockerfile", "gitignore", "csv",
                    "latex", "markdown", "sql",
                },
                sync_install = false,

                -- disable slow treesitter highlight for large files
                highlight = { enable = true },
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,

                -- indent = { enable = true },

                fold = {
                    fold_one_line_after = true,
                },

            })
        end
    }
}
