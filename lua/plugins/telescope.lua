-- 全局检索插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git",
        branch = 'master',
        dependencies = {
            {
                os.getenv("ghproxy") .. "https://github.com/nvim-lua/plenary.nvim.git"
            },
            {
                os.getenv("ghproxy") .. "https://github.com/dawsers/telescope-file-history.nvim.git"
            },
            {
                os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git",
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
            {
                os.getenv("ghproxy") .. "https://github.com/otavioschwanck/telescope-alternate.nvim.git",
            },
        },
        config = function()
            local actions = require("telescope.actions")
            local previewers = require("telescope.previewers")
            local Job = require("plenary.job")
            local new_maker = function(filepath, bufnr, opts)
                filepath = vim.fn.expand(filepath)
                Job:new({
                    command = "file",
                    args = { "--mime-type", "-b", filepath },
                    on_exit = function(j)
                        local mime_type = vim.split(j:result()[1], "/")[1]
                        local file_type = vim.split(j:result()[1], "/")[2]
                        if mime_type == "text" or file_type == "json" then
                            previewers.buffer_previewer_maker(filepath, bufnr, opts)
                        else
                            -- maybe we want to write something to the buffer here
                            vim.schedule(function()
                                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                            end)
                        end
                    end
                }):sync()
            end

            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    file_ignore_patterns = {
                        "%.png", "%.jpg", "%.jpeg", "%.jar", "%.exe",
                        "node_modules", "target", "build", "%.pyc"
                    },
                    buffer_previewer_maker = new_maker,
                    preview = {
                        filesize_limit = 5, -- MB
                    },
                    mappings = {
                        i = {
                            ["<Tab>"] = actions.select_default,
                            ["<esc>"] = actions.close,
                            ["<C-j>"] = actions.preview_scrolling_down,
                            ["<C-k>"] = actions.preview_scrolling_up,
                            ["<C-h>"] = actions.preview_scrolling_left,
                            ["<C-l>"] = actions.preview_scrolling_right,
                        },
                        n = {
                            ["<C-j>"] = actions.preview_scrolling_down,
                            ["<C-k>"] = actions.preview_scrolling_up,
                            ["<C-h>"] = actions.preview_scrolling_left,
                            ["<C-l>"] = actions.preview_scrolling_right,
                        }
                    },
                }

            })

            telescope.load_extension('telescope-alternate')
            telescope.load_extension('bookmarks')

            local workspace_home = os.getenv("WORKSPACE_HOME")
            if workspace_home ~= nil then
                require('file_history').setup {
                    backup_dir = workspace_home .. "/.vim/local-history",
                    git_cmd = "git"
                }
                telescope.load_extension('file_history')

                -- HACK: 默认 CR 行为是 open_selected, 重定向到  revert_selected
                local fh_actions = require("file_history.actions")
                fh_actions.open_selected_hash = fh_actions.revert_to_selected
            end
        end
    }
}


