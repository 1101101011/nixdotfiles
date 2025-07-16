-- Load all modules in lua/
local function load_modules(dir)
  local files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/" .. dir .. "/*.lua", true, true)
  for _, file in ipairs(files) do
    local module_name = file:match("lua/(.+)%.lua$"):gsub("/", ".")
    local ok, module = pcall(require, module_name)
    if ok then
      if type(module.setup) == "function" then
        module.setup()
      elseif type(module.options) == "function" then
        module.options()
      end
    else
      print("Error loading module " .. module_name .. ": " .. module)
    end
  end
end

load_modules("plugins")
require("options").setup()

require("nvim-treesitter.configs").setup({
  -- ensure_installed = "blade",
  highlight = {
    enable = true,
  },
  injections = {
    enable = true,
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "blade",
}

vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

