return {
  setup = function()
    require("flutter-tools").setup({
      ui = {
        border = "rounded",
        notification_style = 'native' | 'plugin'
      },
      decorations = {
        statusline = {
          app_version = false,
          device = false,
          project_config = false,
        }
      },
      debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = false,
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
      },
    })
  end
}

