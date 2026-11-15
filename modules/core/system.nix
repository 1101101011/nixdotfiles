{ pkgs, ... }: {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.problems.handlers."gtk+".broken = "warn";
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
    gnutar
    grim
    grimblast
    gtk3
    gtk4
    gum
    gzip
    jq
    lazygit
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
    psmisc
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
