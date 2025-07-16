return {
  setup = function()
    local custom_theme = require("lualine.themes.auto")
    local custom_colors = {
      bg = "#282828",
      fg = "#e2cca9",
    }
    
    custom_theme = {
      normal = {
        a = { fg = custom_colors.fg, bg = custom_colors.bg },
        b = { fg = custom_colors.fg, bg = custom_colors.bg },
        c = { fg = custom_colors.fg, bg = custom_colors.bg },
        x = { fg = custom_colors.fg, bg = custom_colors.bg },
        y = { fg = custom_colors.fg, bg = custom_colors.bg },
        z = { fg = custom_colors.fg, bg = custom_colors.bg },
      },
    }
    
    local function mode_abbrev()
      local mode_map = {
        ['n']    = 'NOR',  -- Normal
        ['i']    = 'INS',  -- Insert
        ['v']    = 'VIS',  -- Visual
        ['V']    = 'V-L',  -- Visual Line
        ['␖']   = 'V-B',  -- Visual Block
        ['c']    = 'CMD',  -- Command-line
        ['R']    = 'REP',  -- Replace
        ['s']    = 'SEL',  -- Select
        ['S']    = 'S-L',  -- Select Line
        ['␓']   = 'S-B',  -- Select Block
        ['t']    = 'TER',  -- Terminal
        ['Rv']   = 'V-R',  -- Virtual Replace
        ['rm']   = 'MORE', -- More
        ['r']    = 'HIT',  -- Hit-Enter
        ['!']    = 'SHELL',-- Shell
      }
      local mode_code = vim.api.nvim_get_mode().mode
      return mode_map[mode_code] or 'UNK' -- Fallback to 'UNK' for unknown modes
    end
    
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = custom_theme,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { mode_abbrev },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end
}
