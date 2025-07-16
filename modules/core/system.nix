{ config, lib, pkgs, inputs, ... }:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; 
  let
    php = pkgs.php.buildEnv { 
      extraConfig = "
        upload_max_filesize = 2G
        post_max_size = 3G
        memory_limit = 2G
      "; 
    };
  in 
  [
    alsa-utils
    bc
    btop
    bluez
    bluetui
    # blueman
    cmake
    cpio
    cronie
    ffmpeg
    gcc
    glibc
    glib
    grimblast
    grim
    go-upower-notify
    gtk2
    gtk3
    gtk4
    jq
    # kitty
    lazygit
    libgcc
    lsd
    meson
    mpc-cli
    nix-prefetch-git
    nodejs_24
    openssl
    pfetch-rs
    playerctl
    php
    php.packages.composer
    phpExtensions.mysqlnd
    phpExtensions.mysqli
    phpExtensions.pdo
    # R
    sass
    slurp
    socat
    stress-ng
    # superfile
    tree
    tmux
    tlp
    udiskie
    udisks
    unzip
    upower
    vim
    vulkan-tools
    wf-recorder
    wget
    wirelesstools
    xdg-utils
    xplr
    yt-dlp
    zip
    ### hyprland
    libnotify
    ntfs3g
  ];
  # system.copySystemConfiguration = true;
  system.stateVersion = "25.11";
}
