{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    distrobox
    docker-compose
  ];
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
  virtualisation.podman.dockerSocket.enable = true;
}
