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
    # gimp
    # nufraw
    # nufraw-thumbnailer
    # qbittorrent
    # retroarchCustom
    # tetrio-desktop
    # viber
    # zenmap
    # zoom-us
    bat
    beekeeper-studio
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
    libreoffice-still
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
    texliveFull
    vlc
    wl-clipboard
    zed-editor
  ];
}
