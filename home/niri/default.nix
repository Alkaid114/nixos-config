{ config, lib, ... }:
{
  imports = [
    ./wallpaper.nix
    ./swaylock.nix
    ./waybar.nix
    ./dms.nix
    ./mako.nix
  ];
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.polkit-gnome.enable = true; # polkit
  services.swayidle.enable = true; # idle management daemon

  # 夜光护眼软件
  services.wlsunset = {
    enable = true;
    sunset = "00:00";
    sunrise = "00:00";
    temperature.night = 5700;
  };

  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;
  };
  # xdg.configFile = {
  #   # "swaylock".source = ../dotfiles/swaylock;

  #   "niri".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/niri";
  #   # "waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/waybar";
  #   "fuzzel".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/fuzzel";
  # };
  xdg.configFile = {
    "niri".source = ../dotfiles/niri;
    "fuzzel".source = ../dotfiles/fuzzel;
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
}
