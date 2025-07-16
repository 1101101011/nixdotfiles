return {
  setup = function()
    require('telescope').setup({
      pickers = {
        find_files = {
          hidden = true,
        }
      }
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})
  end
}
