return {
  setup = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      float_opts = {
        border = "curved",
        title_pos = "right",
      },
    })
    -- local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<Leader>tf', '<cmd>ToggleTerm direction=float<CR>', {})
    vim.keymap.set('n', '<Leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', {})
    vim.keymap.set('n', '<Leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', {})
  end,
}
