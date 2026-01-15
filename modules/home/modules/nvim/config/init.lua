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
load_modules("native")
require("options").setup()
require("keybinds").setup()

--[[ vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})

local treesitter = require("nvim-treesitter")
treesitter.setup({
  highlight = {
    enable = true,
  },
  injections = {
    enable = true,
  },
}) ]]
