{ username, ... }:
{
  xdg.configFile."swaylock/config".text = ''
        image = /home/${username}/Pictures/wallpaper.png
  '';
}
