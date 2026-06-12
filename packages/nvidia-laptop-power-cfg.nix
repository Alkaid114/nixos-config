{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "nvidia-laptop-power-cfg";
  version = "2026-1-17";

  src = pkgs.fetchFromGitLab {
    owner = "asus-linux";
    repo = "nvidia-laptop-power-cfg";
    rev = "a73f9b9b51d732699aed5a631b54337fa061a683";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/udev/rules.d
    cp nvidia.rules $out/lib/udev/rules.d/

    mkdir -p $out/lib/modprobe.d
    cp nvidia.conf $out/lib/modprobe.d/

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "NVIDIA laptop power configuration scripts for ASUS and others";
    homepage = "https://gitlab.com/asus-linux/nvidia-laptop-power-cfg";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
