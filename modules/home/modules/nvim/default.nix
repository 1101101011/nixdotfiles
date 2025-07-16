{
  pkgs,
  inputs,
  config,
  neovim,
  ...
}: 
let
  none-ls-extras-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "none-ls-extras-nvim";
    src = inputs.none-ls-extras;
    doCheck = false;
  };
  csv-view-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "csv-view-nvim";
    src = inputs.csv-view;
  };
  showkeys-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "showkeys-nvim";
    src = inputs.showkeys;
  };
in
{
  home.packages = with pkgs; [
    # lsp
    bash-language-server
    clang-tools
    lua-language-server
    nil
    # (rWrapper.override {
    #   packages = with rPackages; [ 
    #     languageserver 
    #     formatR
    #     lintr
    #     styler
    #     ggplot2
    #     dplyr
    #     xlsx
    #     readxl
    #     writexl
    #   ];
    # })
    # docker
    docker-compose-language-service
    dockerfile-language-server-nodejs
    docker-language-server
    # intelephense
    phpactor
    omnisharp-roslyn
    sqls
    # cargo
    rust-analyzer
    typescript-language-server
    vscode-langservers-extracted
    vue-language-server
    # vtsls
    csharp-ls
    # formatters
    hadolint
    alejandra
    blade-formatter
    csharpier
    stylua
    eslint
    eslint_d
    nodePackages.prettier
    prettierd
    # phpPackages.php-cs-fixer
    shellcheck
    shfmt
    sqlfluff
    # debuggers
    # lldb_19
    # gdb
    # netcoredbg
  ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      alpha-nvim
      indent-blankline-nvim
      gruvbox-material
      comment-nvim
      which-key-nvim
      mini-nvim
      telescope-nvim
      nvim-web-devicons
      telescope-ui-select-nvim
      undotree
      neo-tree-nvim
      toggleterm-nvim
      plenary-nvim
      nvim-lspconfig
      none-ls-nvim
      none-ls-extras-nvim
      nvim-cmp
      luasnip
      cmp_luasnip
      friendly-snippets
      cmp-nvim-lsp
      neodev-nvim
      # {
      #   plugin = nvim-dap;
      #   type = "lua";
      #   config = toLuaFile ./nvim/plugins/nvim-dap.lua;
      # }
      # nvim-dap-ui
      # nvim-dap-virtual-text
      gitsigns-nvim
      lualine-nvim
      copilot-vim
      cord-nvim
      nvim-treesitter.withAllGrammars
      (nvim-treesitter.withPlugins (_:
        nvim-treesitter.allGrammars
        ++ [
          (pkgs.tree-sitter.buildGrammar {
            language = "blade";
            version = "v0.11.0";
            src = pkgs.fetchFromGitHub {
              owner = "EmranMR";
              repo = "tree-sitter-blade";
              rev = "4ad4d56aca189bf4fa18b8896f9ed4a5e5ddf618";
              sha256 = "sha256-qRjgWWsFZ9TUVqcGuAFfL/6DW6AqdUuD8tjTkwxpxYM=";
            };
          })
        ]
      ))
      showkeys-nvim
      csv-view-nvim
    ];
  };
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}

