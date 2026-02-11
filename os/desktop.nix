{ pkgs, ... }:
{
  imports = [
    ./system
    ./program
    ../hardware/keyboard.nix
    ../hardware/audio.nix
    ../hardware/printing.nix
  ];

  services.libinput.enable = true;
  programs.dconf.enable = true;
  security.polkit.enable = true;
  xdg.portal.enable = true;
  environment.systemPackages = with pkgs; [
    btrfs-progs
    mesa-demos
  ];
}
