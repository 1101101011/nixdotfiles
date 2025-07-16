return {
  setup = function()
    vim.g.gruvbox_material_background = 'medium' -- 'soft', 'medium', 'hard'
    vim.g.gruvbox_material_palette = 'mix' -- 'original', 'mix', 'material'
    
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_enable_bold = 1
    
    vim.cmd('colorscheme gruvbox-material')
  end 
}
