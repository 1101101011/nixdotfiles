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
    awscli2
    bat
    # blender
    brave
    discord
    eww
    fastfetch
    fzf
    # gimp
    hypridle
    hyprpaper
    inputs.zen-browser.packages."${system}".default
    kitty
    laravel
    # texliveFull
    libreoffice-still
    # mangohud
    nautilus
    nitch
    obs-studio
    protonup-ng
    qbittorrent
    qview
    # retroarchCustom
    rofi-wayland
    # tetrio-desktop
    # cargo-tauri
    vlc
    wl-clipboard
    # zoom-us
  ];
}
