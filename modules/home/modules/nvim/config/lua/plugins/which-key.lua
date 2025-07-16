return {
  setup = function()
    local wk = require("which-key")
    wk.add({
      --files
      { "<leader>f", group = "file" }, -- group
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers", mode = "n" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags", mode = "n" },
      { "<leader>f1", hidden = true }, -- hide this keymap
      { "<C-f>", desc = "File Tree", mode = "n" },
      --undo
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree", mode = "n" },
      --code code manipulation
      { "<leader>c", group = "code" }, -- group
      { "<leader>cf", desc = "Format Code", mode = "n" },
      { "<leader>ca", desc = "Code Action", mode = "n" },
      { "<leader>cd", desc = "Definition", mode = "n" },
      { "<leader>cr", desc = "References", mode = "n" },
      { "<leader>ci", desc = "Implementation", mode = "n" },
      --git stuff
      { "<leader>g", group = "Git" }, -- group
      { "<leader>gb", "<cmd>Gitsigns blame<cr>", desc = "Git Blame", mode = "n" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk", mode = "n" },
      --terminal
      { "<leader>t", group = "Terminal" }, -- group
      { "<leader>tf", desc = "Floating Terminal", mode = "n" },
      { "<leader>tv", desc = "Vertical Terminal", mode = "n" },
      { "<leader>th", desc = "Horizontal Terminal", mode = "n" },
      --others
      { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
      { "<leader>b", group = "buffers", expand = function()
          return require("which-key.extras").expand.buf()
        end
      },
    })
  end
}

