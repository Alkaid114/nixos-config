{config, ...}:
{
  imports = [
    ./wallpaper.nix
    ./swaylock.nix
  ];
  xdg.configFile = {
    "swaylock".source = ../dotfiles/swaylock;

    "niri".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/niri";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/waybar";
    "fuzzel".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/fuzzel";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}