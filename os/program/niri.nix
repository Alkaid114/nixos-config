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
      patches = (oldAttrs.patches or [ ]) ++ [
        ./patches/niri-shm-2511.patch
      ];
      # pname = "niri";
      # version = "unstable-${builtins.substring 0 7 niriCommit}";

      # src = pkgs.fetchFromGitHub {
      #   owner = "niri-wm";
      #   repo = "niri";
      #   rev = niriCommit;
      #   hash = "sha256-lqweVTwHhYc+9T33cysp38gVwxaibGJHriOPZXWyhCY=";
      # };

      # cargoPatches = [
      #   ./patches/niri-shm-main.patch
      #   ./patches/niri-blur-wip.patch
      # ];

      # cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
      #   name = "${pname}-${version}-vendor.tar.gz";
      #   inherit src;
      #   outputHashMode = "recursive"; 
      #   outputHashAlgo = "sha256";
      #   outputHash = "sha256-Wv/SNaguColGBI5CPqBIbdJATuA+EOPJRfJw42Pj7ZE=";
      # };

      # preBuild = ''
      #   for dir in niri-config niri-ipc niri-visual-tests; do
      #     if [ -d "$dir" ] && [ ! -f "$dir/.cargo-checksum.json" ]; then
      #       echo '{"files":{}}' > "$dir/.cargo-checksum.json"
      #     fi
      #   done

      #   find . -name .cargo-checksum.json -exec sed -i 's/"files":{[^}]*}/"files":{}/g' {} \;
      # '';

      # cargoVendorDir = null;

      # postPatch = ''
      #   patchShebangs resources/niri-session
      #   substituteInPlace resources/niri.service \
      #     --replace-fail 'ExecStart=niri' "ExecStart=$out/bin/niri"
      # '';

      # doInstallCheck = false;

      # env = oldAttrs.env // {
      #   NIRI_BUILD_COMMIT = niriCommit;
      # };
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
