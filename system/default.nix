{ ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./virtual.nix
    ./basic.nix
    ./fonts.nix
    ./kernel.nix
    ./network.nix
    ./nixSettings.nix
    ./users.nix
    ./niri
    ./proxy.nix
    ./envVars.nix
  ];
}
