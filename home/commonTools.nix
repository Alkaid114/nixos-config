{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice
      vlc
    ]
    ++ (with kdePackages; [
      kate
      okular
      gwenview
    ]);
}
