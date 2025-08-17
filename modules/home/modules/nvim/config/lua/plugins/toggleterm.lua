return {
  setup = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      float_opts = {
        border = "curved",
        title_pos = "right",
      },
    })
  end,
}
