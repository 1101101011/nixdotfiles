{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
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
    upower-notify
    gtk2
    gtk3
    gtk4
    gum
    jq
    lazygit
    libgcc
    lm_sensors
    lsd
    meson
    mpc
    nix-prefetch-git
    # nodejs_25
    openssl
    pfetch-rs
    playerctl
    # R
    sass
    slurp
    socat
    stress-ng
    superfile
    tree
    tmux
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
  system.stateVersion = "26.05";
}
