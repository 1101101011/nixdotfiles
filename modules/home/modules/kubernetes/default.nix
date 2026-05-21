{ pkgs, config, lib, ... }:

{
  options = {
    kube-home.enable = lib.mkEnableOption "Enable K9S Kubernetes cluster";
  };
  config = lib.mkIf config.kube-home.enable {
    home.packages = with pkgs; [
      kubectl
      k9s
      kubernetes-helm
    ];

    home.sessionVariables = {
      KUBECONFIG = "$HOME/.kube/config";
    };
  };
}
