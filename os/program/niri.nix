{
  pkgs,
  inputs,
  config,
  ...
}:
{
  services.xserver.xkb.layout = "us";

  programs.niri = {
    enable = true;
    useNautilus = true;
    package = pkgs.niri.overrideAttrs (oldAttrs: rec {
      patches = (oldAttrs.patches or [ ]) ++ [
        ./patches/niri-shm-2604.patch
      ];
    });
  };

  environment.systemPackages = with pkgs; [
    kitty
    fuzzel
    xwayland-satellite
    nautilus
    adwaita-icon-theme
    gnome-themes-extra
    file-roller
  ];

  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };
    mime.enable = true;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      niri = {
        prettyName = "Niri";
        binPath = "${pkgs.niri}/bin/niri-session";
      };
    };
  };
}
