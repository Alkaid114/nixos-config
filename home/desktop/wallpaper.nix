{ pkgs, ... }:
{
  home.file = {
    "Pictures/wallpapers/nixos/nix-wallpaper-nineish-catppuccin-mocha-alt.png".source =
      "${pkgs.nixos-artwork.wallpapers.nineish-catppuccin-mocha-alt}/share/backgrounds/nixos/nix-wallpaper-nineish-catppuccin-mocha-alt.png";

    "Pictures/wallpapers/nixos/nix-wallpaper-nineish.png".source =
      "${pkgs.nixos-artwork.wallpapers.nineish}/share/backgrounds/nixos/nix-wallpaper-nineish.png";
  };
}
