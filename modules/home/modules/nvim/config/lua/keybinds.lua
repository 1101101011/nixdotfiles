return {
  setup = function ()
    -- local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<Leader>tf", "<CMD>ToggleTerm direction=float<CR>", {})
    vim.keymap.set("n", "<Leader>tv", "<CMD>ToggleTerm direction=vertical<CR>", {})
    vim.keymap.set("n", "<Leader>th", "<CMD>ToggleTerm direction=horizontal<CR>", {})
  end
}
