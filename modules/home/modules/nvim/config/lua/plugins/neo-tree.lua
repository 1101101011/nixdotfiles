return {
  setup = function()
    local neotree = require("neo-tree")
    
    neotree.setup({
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          visible = true,
        },
      },
    })
    
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE", fg = "NONE" })
    
    vim.keymap.set("n", "<C-f>", ":Neotree toggle filesystem right<CR>", {})
  end
}
