{ pkgs, config, ... }:
let
  tuigreetRun = pkgs.writeShellScript "tuigreet-run" ''
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=niri
    exec ${pkgs.dbus}/bin/dbus-run-session ${pkgs.tuigreet}/bin/tuigreet \
      --time --asterisks --remember --remember-session \
      --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions
  '';
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreetRun}";
      };
    };
  };
}
