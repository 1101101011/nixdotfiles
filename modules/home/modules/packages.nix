{ lib, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    awscli2
    # aseprite
    inputs.zen-browser.packages."${system}".default
    # blender
    bat
    brave
    discord
    eww
    fastfetch
    fzf
    # gimp
    hypridle
    hyprpaper
    kitty
    laravel
    libreoffice-still
    # mangohud
    nautilus
    nitch
    obs-studio
    protonup-ng
    # qbittorrent
    qview
    rofi-wayland
    # tetrio-desktop
    vlc
    wl-clipboard
    # zoom-us
  ];
}
