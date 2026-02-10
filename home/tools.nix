{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice-fresh
      mpv
      gparted
    ]
    ++ (with kdePackages; [
      okular
      gwenview
      filelight
    ]);
}
