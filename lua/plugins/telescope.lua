return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git",
        tag = '0.1.5',
        dependencies = {
            {
                os.getenv("ghproxy") .. "https://github.com/nvim-lua/plenary.nvim.git"
            },
            {
                os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git",
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            }
        },
        config = function()
            local map = vim.api.nvim_set_keymap
            local opt = { noremap = true, silent = true }
            map("n", "<A-f>", "/", opt)                         -- 页面内关键词查找
            map("n", "<C-F>", ":Telescope live_grep<CR>", opt)  -- 全局关键词查找
            map("n", "<C-o>", ":Telescope find_files<CR>", opt) -- 全局文件查找
            map("n", "<A-o>", ":Telescope find_files<CR>", opt) -- 全局文件查找

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

            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "%.png", "%.jpg", "%.jpeg", "%.jar", "%.exe",
                        "node_modules", "target", "build"
                    },
                    buffer_previewer_maker = new_maker,
                    preview = {
                        filesize_limit = 5, -- MB
                    },
                }

            })
        end
    }
}
