return {
  setup = function()
    require("toggleterm").setup({
      float_opts = {
        border = 'curved',
        title_pos = 'right'
      },
    })
    vim.keymap.set('n', '<Leader>tf', ':ToggleTerm direction=float <CR>', {})
    vim.keymap.set('n', '<Leader>tv', ':ToggleTerm direction=vertical <CR>', {})
    vim.keymap.set('n', '<Leader>th', ':ToggleTerm direction=horizontal <CR>', {})
  end
}
