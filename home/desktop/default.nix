{ ... }:
{
  imports = [
    ./fcitx5.nix
    ./fuzzel.nix
    ./kanshi.nix
    ./kitty.nix
    ./ghostty.nix
    ./niri
    ./social.nix
    ./stylix.nix
    ./theme.nix
    ./tools.nix
    ./wallpaper.nix
  ];

  dconf.settings = {
    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
    };
  };
}
