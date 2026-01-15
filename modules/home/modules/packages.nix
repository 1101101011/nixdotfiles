{
  lib,
  config,
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
    # aseprite
    # anydesk
    # awscli2
    bat
    # blender
    brave
    cheese
    discord
    eww
    fastfetch
    fzf
    # gimp
    hypridle
    hyprpaper
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
    kitty
    laravel
    texliveFull
    libreoffice-still
    # mangohud
    nautilus
    nitch
    obs-studio
    pixieditor
    protonup-ng
    # qbittorrent
    qview
    # retroarchCustom
    rofi
    # tetrio-desktop
    # cargo-tauri
    vlc
    wl-clipboard
    # zenmap
    # zoom-us
    zed-editor
  ];
}
