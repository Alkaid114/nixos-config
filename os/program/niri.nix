{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./dm.nix
    # ../../home/stylix
  ];

  programs.niri = {
    enable = true;
    useNautilus = true;
    package = pkgs.niri.overrideAttrs (oldAttrs: {
      doCheck = false;
      patches = (oldAttrs.patches or [ ]) ++ [
        ./patches/niri-shm.patch
      ];
      env = (oldAttrs.env or { }) // {
        RUSTFLAGS = "-C target-cpu=native";
        CARGO_PROFILE_RELEASE_OPT_LEVEL = "3";
        CARGO_PROFILE_RELEASE_LTO = "fat";
      };
    });
  };

  environment.systemPackages = with pkgs; [
    kitty
    fuzzel
    xwayland-satellite
    gnome-keyring
    nautilus
    gnome.gvfs
    adwaita-icon-theme
    gnome-themes-extra
    hyprpolkitagent
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

  # programs.uwsm = {
  #   enable = true;
  #   waylandCompositors = {
  #     niri = {
  #       prettyName = "Niri";
  #       binPath = "${pkgs.niri}/bin/niri";
  #     };
  #   };
  # };

  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
    enableClipboardPaste = true;
  };
}
