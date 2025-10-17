{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    distrobox
   # nvidia-container-toolkit
  ];

    virtualisation.podman.enable = true;
#   hardware.nvidia-container-toolkit.enable = true;
}
