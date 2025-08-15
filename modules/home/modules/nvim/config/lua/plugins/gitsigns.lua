return {
  setup = function()
    require("gitsigns").setup({
      current_line_blame = true,
    })
    vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", {})
    vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<CR>", {})
  end
}

