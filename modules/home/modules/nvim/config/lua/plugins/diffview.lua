return {
  setup = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
          disable_diagnostics = true,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
      },
      file_panel = {
        win_config = {
          position = "right",
          width = 35,
        },
      },
    })
  end,
}
