--
local keymap = require("keymap")
local util = require("util")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/gbprod/yanky.nvim.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/kkharji/sqlite.lua.git",
            os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git",
        },
        config = function()
            local workspace_home = os.getenv("WORKSPACE_HOME")
            local yanky = require("yanky")
            yanky.setup({
                ring = {
                    storage = "sqlite",
                    storage_path = workspace_home .. "/.vim/yanky.db",

                    history_length = 100,
                    sync_with_numbered_registers = true,
                    cancel_event = "update",
                    ignore_registers = { "_" },
                    update_register_on_cycle = false,
                },
                system_clipboard = {
                    sync_with_ring = false,
                },
            })
            require("telescope").load_extension("yank_history")

            keymap.map2cmd("n", keymap.list_yank_list, "<CMD>Telescope yank_history initial_mode=normal<CR>")
            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")

            vim.keymap.set("n", keymap.pre_yank, function()
                if yanky.can_cycle() then
                    yanky.cycle(1)
                else
                    -- vim.api.nvim_feedkeys("<Tab>", "n", true)
                end
            end, { silent = true })

            vim.keymap.set("n", keymap.nex_yank, function()
                if yanky.can_cycle() then
                    yanky.cycle(-1)
                else
                    -- vim.api.nvim_feedkeys("<Tab>", "n", true)
                end
            end, { silent = true })
        end
    }
}
