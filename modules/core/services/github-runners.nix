{
  config,
  pkgs,
  ...
}:
{
  /* programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib # libstdc++
      zlib
      icu
      openssl
      glibc
    ];
  }; */
  # GitHub Actions runner as a system service
  services.github-actions-runner.instances = {
    enic-mis = {
      enable = true;
      url = "https://github.com/RonRon-Dev/ENIC-INTERNS-PROJECT";
      name = "enic-mis-nixos";
      extraLabels = [
        "nixos"
        "self-hosted"
      ];
      extraPackages = with pkgs; [
        dotnet-sdk_10
        nodejs_25
        docker
        nix
      ];
    };
  };
}
