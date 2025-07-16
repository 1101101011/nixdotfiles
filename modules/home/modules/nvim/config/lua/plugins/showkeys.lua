return {
  setup = function()
    require("showkeys").setup({
    	timeout = 3,
    	maxkeys = 4,
    	position = "top-right",
    	show_count = true,
      winopts = {
        border = "rounded",
      },
    })
    vim.keymap.set("n", "<Leader>sk", ":ShowkeysToggle<CR>", {})
  end
}
