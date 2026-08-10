{ pkgs, ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # R
    # blueman
    # nodejs_25
    alsa-utils
    bc
    bluetui
    bluez
    btop
    cmake
    cpio
    cronie
    curl
    ffmpeg
    gcc
    glib
    glibc
    gnutar
    grim
    grimblast
    gtk2
    gtk3
    gtk4
    gum
    gzip
    jq
    lazygit
    libgcc
    libnotify
    lm_sensors
    lsd
    meson
    mpc
    nix-prefetch-git
    ntfs3g
    openssl
    pfetch-rs
    playerctl
    sass
    slurp
    socat
    stress-ng
    superfile
    tmux
    tree
    udiskie
    udisks
    unzip
    upower
    upower-notify
    vim
    vulkan-tools
    wf-recorder
    wget
    wirelesstools
    xdg-utils
    xplr
    yt-dlp
    zip
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      openssl
      stdenv.cc.cc
    ];
  };
  # system.copySystemConfiguration = true;
  system.stateVersion = "26.05";
}
