{ ... }:
{
  imports = [
    ./envVars.nix
    ./basic.nix
    ./network.nix
    ./nix.nix
    ./users.nix
    ./boot.nix
  ];
}
