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
        ["n"] = "NOR", -- Normal
        ["i"] = "INS", -- Insert
        ["v"] = "VIS", -- Visual
        ["V"] = "V-L", -- Visual Line
        ["␖"] = "V-B", -- Visual Block
        ["c"] = "CMD", -- Command-line
        ["R"] = "REP", -- Replace
        ["s"] = "SEL", -- Select
        ["S"] = "S-L", -- Select Line
        ["␓"] = "S-B", -- Select Block
        ["t"] = "TER", -- Terminal
        ["Rv"] = "V-R", -- Virtual Replace
        ["rm"] = "MORE", -- More
        ["r"] = "HIT", -- Hit-Enter
        ["!"] = "SHELL", -- Shell
      }
      local mode_code = vim.api.nvim_get_mode().mode
      return mode_map[mode_code] or "UNK" -- Fallback to 'UNK' for unknown modes
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
  end,
}
--[[ -- statusline.lua
local M = {}

local mode_map = {
  ["n"] = "NOR",
  ["i"] = "INS",
  ["v"] = "VIS",
  ["V"] = "V-L",
  ["␖"] = "V-B", -- Visual Block
  ["c"] = "CMD",
  ["R"] = "REP",
  ["s"] = "SEL",
  ["S"] = "S-L",
  ["␓"] = "S-B", -- Select Block
  ["t"] = "TER",
  ["Rv"] = "V-R",
  ["rm"] = "MORE",
  ["r"] = "HIT",
  ["!"] = "SHELL",
}

local function mode()
  local code = vim.api.nvim_get_mode().mode
  return mode_map[code] or "UNK"
end

local function branch()
  local b = vim.b.gitsigns_head or vim.g.gitsigns_head
  if b and b ~= "" then
    return " " .. b
  end
  return ""
end

local function diff()
  local signs = vim.b.gitsigns_status_dict
  if not signs then
    return ""
  end
  local parts = {}
  if (signs.added or 0) > 0 then
    table.insert(parts, "+" .. signs.added)
  end
  if (signs.changed or 0) > 0 then
    table.insert(parts, "~" .. signs.changed)
  end
  if (signs.removed or 0) > 0 then
    table.insert(parts, "-" .. signs.removed)
  end
  return table.concat(parts, " ")
end

local function diagnostics()
  local counts = vim.diagnostic.count(0)
  local parts = {}
  if (counts[vim.diagnostic.severity.ERROR] or 0) > 0 then
    table.insert(parts, "" .. counts[vim.diagnostic.severity.ERROR])
  end
  if (counts[vim.diagnostic.severity.WARN] or 0) > 0 then
    table.insert(parts, "" .. counts[vim.diagnostic.severity.WARN])
  end
  if (counts[vim.diagnostic.severity.INFO] or 0) > 0 then
    table.insert(parts, "" .. counts[vim.diagnostic.severity.INFO])
  end
  if (counts[vim.diagnostic.severity.HINT] or 0) > 0 then
    table.insert(parts, "" .. counts[vim.diagnostic.severity.HINT])
  end
  return table.concat(parts, " ")
end

local function filename()
  local name = vim.fn.expand("%:t")
  if name == "" then
    name = "[No Name]"
  end
  local modified = vim.bo.modified and " [+]" or ""
  local readonly = vim.bo.readonly and " [RO]" or ""
  return name .. modified .. readonly
end

local function encoding()
  return vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
end

local function filetype()
  return vim.bo.filetype ~= "" and vim.bo.filetype or "none"
end

local function progress()
  local cur = vim.fn.line(".")
  local total = vim.fn.line("$")
  if cur == 1 then
    return "Top"
  end
  if cur == total then
    return "Bot"
  end
  return string.format("%2d%%%%", math.floor(cur / total * 100))
end

local function location()
  return string.format("%3d:%-2d", vim.fn.line("."), vim.fn.col("."))
end

local function pad(s, left, right)
  left = left or 1
  right = right or 1
  if s == "" then
    return ""
  end
  return string.rep(" ", left) .. s .. string.rep(" ", right)
end

local function sections(parts)
  local result = {}
  for _, p in ipairs(parts) do
    local val = type(p) == "function" and p() or p
    if val and val ~= "" then
      table.insert(result, pad(val))
    end
  end
  return table.concat(result, "|")
end

function M.render()
  local left = sections({ mode, branch, diff, diagnostics, filename })
  local right = sections({ encoding, filetype, progress, location })
  return left .. "%=" .. right
end

function M.setup()
  vim.o.statusline = "%!v:lua.require('statusline').render()"
  vim.o.laststatus = 3 -- globalstatus equivalent
end
saadsd

return M ]]
