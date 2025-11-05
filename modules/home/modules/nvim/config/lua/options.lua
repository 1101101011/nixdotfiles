return {
  setup = function()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '
    vim.o.clipboard = 'unnamedplus'
    vim.o.number = true;
    vim.o.relativenumber = true;
    vim.o.signcolumn = 'yes';
    vim.opt.clipboard.append = "unnamedplus";
    vim.opt.cursorline = false;
    vim.setcursotline = true;
    vim.o.foldmethod = 'manual';
    -- vim.o.foldexpr = 'nvim_treesitter#foldexpr()';
    vim.o.foldlevel = 99;
    vim.o.undofile = true;
    vim.o.foldenable = true;
    vim.o.foldcolumn = '1';
    vim.cmd("set laststatus=3")
    vim.cmd("set expandtab")
    vim.cmd("set tabstop=2")
    vim.cmd("set softtabstop=2")
    vim.cmd("set shiftwidth=2")
    vim.cmd("set guicursor=n-v-c-i:block")
    vim.cmd("set guicursor=i:blinkon100")
    vim.keymap.set("n", "<leader>bn", "<CMD>bn<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>bp", "<CMD>bp<CR>", { noremap = true, silent = true })
    vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
    vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
    vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
    vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })
    vim.diagnostic.config({
      signs = false
    })
    vim.cmd [[
      highlight clear SignColumn
      highlight SignColumn guibg=CLEAR
    ]]
    vim.opt.fillchars = { eob = " " }
  end
}
