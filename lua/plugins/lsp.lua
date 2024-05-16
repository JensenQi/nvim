--
return {
    {
        os.getenv("ghproxy") .. "https://github.com/williamboman/mason.nvim.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/williamboman/mason-lspconfig.nvim.git",
            os.getenv("ghproxy") .. "https://github.com/neovim/nvim-lspconfig.git",
            os.getenv("ghproxy") .. "https://github.com/mfussenegger/nvim-jdtls.git",
        },
        config = function()
            require('mason').setup({
                log_level = vim.log.levels.DEBUG,
                github = { download_url_template = os.getenv("ghproxy") .. "https://github.com/%s/releases/download/%s/%s", },
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                },

            })
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'pyright', 'jdtls', 'clangd', 'rust_analyzer',
                    'tsserver', 'vuels', 'eslint', 'lua_ls',
                    'html', 'cssls', 'eslint', 'gopls', -- 'metals',
                    'bashls', 'jsonls', 'lemminx'
                },
            })

            local lsp = require('lspconfig')
            if _G.PROJECT_TYPE == "python" then
                lsp.pyright.setup({})
            elseif _G.PROJECT_TYPE == "cmake" then
                lsp.clangd.setup({})
            elseif _G.PROJECT_TYPE == "rust" then
                lsp.rust_analyzer.setup({})
            elseif _G.PROJECT_TYPE == "lua" then
                lsp.lua_ls.setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' }
                            }
                        }
                    }
                })
            elseif _G.PROJECT_TYPE == "java" then
                local jdt_path = _G.NVIM_HOME .. "/share/jdt/1.33.0"
                local config = {
                    cmd = {
                        _G.NVIM_HOME .. '/share/jdk/17.0.2/bin/java',
                        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                        '-Dosgi.bundles.defaultStartLevel=4',
                        '-Declipse.product=org.eclipse.jdt.ls.core.product',
                        '-Dosgi.checkConfiguration=true',
                        '-Dosgi.sharedConfiguration.area=' .. jdt_path .. '/config_linux',
                        '-Dosgi.sharedConfiguration.area.readOnly=true',
                        '-Dosgi.configuration.cascaded=true',
                        '-Xms1G',
                        '--add-modules=ALL-SYSTEM',
                        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                        '-jar', jdt_path .. '/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
                        '-data', '/tmp/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
                    },
                    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
                    settings = { java = {} },
                    init_options = { bundles = {} },
                }
                -- jdtls 比较特殊, 每个 buf 都需要在 filetype 事件中 attach
                -- 这里注册一下事件
                -- 另一种做法是把 jdtls 放到 ftplugin/java.lua 中
                vim.api.nvim_create_autocmd("FileType", {
                    callback = function()
                        -- local cfg = {
                        --     cmd = {_G.NVIM_HOME .. '/share/jdt/1.33.0/bin/jdtls'},
                        --     root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
                        -- }
                        -- require('jdtls').start_or_attach(cfg)
                        if vim.bo.filetype == 'java' then
                            require('jdtls').start_or_attach(config)
                        end
                    end
                })
            end
        end
    }
}

