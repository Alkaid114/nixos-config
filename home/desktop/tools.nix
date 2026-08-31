{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice-fresh
      mpv
    ]
    ++ (with kdePackages; [
      okular
      gwenview
      filelight
      partitionmanager
    ]);
}
