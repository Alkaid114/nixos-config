{
  pkgs,
  inputs,
  config,
  ...
}:
{
  # services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  programs.niri = {
    enable = true;
    useNautilus = true;
    package = pkgs.niri.overrideAttrs (oldAttrs: {
      doCheck = false;
      patches = (oldAttrs.patches or [ ]) ++ [
        ./patches/niri-shm.patch
      ];
      #env = (oldAttrs.env or { }) // {
      #  RUSTFLAGS = "-C target-cpu=native";
      #  CARGO_PROFILE_RELEASE_OPT_LEVEL = "3";
      #  CARGO_PROFILE_RELEASE_LTO = "fat";
      #};
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
    adwaita-icon-theme
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
