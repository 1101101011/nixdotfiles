{
  pkgs,
  inputs,
  ...
}:
let
  retroarchCustom = pkgs.retroarch.withCores (
    cores: with cores; [
      desmume
      mgba
      genesis-plus-gx
      snes9x
      beetle-psx-hw
    ]
  );
in
{
  home.packages = with pkgs; [
    # anydesk
    # aseprite
    # blender
    # cargo-tauri
    # detect-it-easy
    # ghidra
    gimp
    # darktable
    rawtherapee
    # nufraw
    # nufraw-thumbnailer
    # qbittorrent
    # retroarchCustom
    # tetrio-desktop
    # viber
    # zenmap
    # zoom-us
    bat
    # beekeeper-studio
    brave
    cheese
    discord
    eww
    fastfetch
    fzf
    hypridle
    hyprpaper
    inputs.quickshell.packages."${stdenv.hostPlatform.system}".default
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
    kitty
    laravel
    libreoffice
    mangohud
    nautilus
    nitch
    obs-studio
    opencode
    pixieditor
    protonup-ng
    qt6.qtwayland
    qview
    rofi
    slides
    presenterm
    texliveFull
    # tuios
    unrar
    vlc
    wl-clipboard
    zed-editor
  ];
}
