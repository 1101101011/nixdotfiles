return {
  setup = function()
    local null_ls = require("null-ls")
    
    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.alejandra,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.csharpier,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.dart_format,
        -- null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.blade_formatter,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.textidote,
        -- null_ls.builtins.formatting.format_r,
        -- null_ls.builtins.formatting.styler,
        -- null_ls.builtins.diagnostics.lintr,
        -- null_ls.builtins.diagnostics.sqlfluff,
    
        require("none-ls.diagnostics.eslint_d"),
      },
    })
  end
}
