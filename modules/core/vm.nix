{ config, lib, pkgs, inputs, ... }:
{
  options = {
    vm.enable = lib.mkEnableOption "Enable Virtualization and VM management tools";
  };
  config = lib.mkIf config.vm.enable {
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice 
      spice-gtk
      spice-protocol
      virtio-win
      win-spice
      adwaita-icon-theme
      # podman-tui
      # podman-compose
      # dive
      docker-compose
      lazydocker
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          # ovmf.enable = true;
          # ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
      containers.enable = true;
      docker = {
        enable = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };
      # podman = {
      #   enable = true;
      #   dockerCompat = true;
      #   defaultNetwork.settings.dns_enabled = true;
      # };
    };
    services.spice-vdagentd.enable = true;
  };
}
