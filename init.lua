local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        os.getenv("ghproxy") .. "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("profile")
require("keymap").init()

require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
    git = {
        url_format = os.getenv("ghproxy") .. "https://github.com/%s.git",
        timeout = 300,
    },
})
