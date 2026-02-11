{ ... }:
{
  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
