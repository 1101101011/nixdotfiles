{
  config,
  lib,
  ... 
}:
{
  options = {
    kube.enable = lib.mkEnableOption "Enable K3S Kubernetes cluster";
  };
  config = lib.mkIf config.kube.enable {
    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = [
        "--write-kubeconfig-mode=0644"
      ];
    };
  };
}
