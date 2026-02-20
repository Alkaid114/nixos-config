{
  pkgs,
  inputs,
  config,
  ...
}:
let
  niriCommit = "a2a52911757cb3b497db9407592f9b4c439571ea";
in
{
  services.xserver.xkb.layout = "us";

  programs.niri = {
    enable = true;
    useNautilus = true;
    package = pkgs.niri.overrideAttrs (oldAttrs: rec {
      # pname = "niri";
      # version = "unstable-${builtins.substring 0 7 niriCommit}";

      # src = pkgs.fetchFromGitHub {
      #   owner = "niri-wm";
      #   repo = "niri";
      #   rev = niriCommit;
      #   hash = "sha256-lqweVTwHhYc+9T33cysp38gVwxaibGJHriOPZXWyhCY=";
      # };

      # cargoDeps = oldAttrs.cargoDeps.overrideAttrs (pkgs.lib.const {
      #   inherit src patches;
      #   outputHashMode = "recursive";
      #   outputHashAlgo = "sha256";
      #   outputHash = "sha256-WEk60uhpXuQk5szOKohnjMYz7uq+jvnRfyMKUAz3BLM=";
      # });

      # postPatch = ''
      #   patchShebangs resources/niri-session
      # '';

      # doCheck = false;
      patches = (oldAttrs.patches or [ ]) ++ [
        ./patches/niri-shm-2511.patch
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
