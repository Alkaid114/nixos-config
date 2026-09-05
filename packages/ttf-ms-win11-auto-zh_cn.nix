{ pkgs }:

let
  version = "10.0.26100.1742-4";
  # Windows 11 24H2 Enterprise evaluation ISO
  iso = pkgs.fetchurl {
    url = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1742.240906-0331.ge_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso";
    hash = "sha256-dVqQ1D6CanS54ZMqNHiLiY4CgnJDm3d+VZPe6NU2Iq4=";
  };
in
pkgs.runCommand "ttf-ms-win11-auto-zh_cn-${version}"
  {
    outputHash = "sha256-vNdjFzrqcKjvWREV1uXghQi9lcEtHp/lLJmPvSJRQNo=";
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    nativeBuildInputs = [
      pkgs.p7zip
      pkgs.wimlib
    ];
    meta = with pkgs.lib; {
      description = "Microsoft Windows 11 Simplified Chinese fonts (YaHei, SimSun), extracted from the official ISO";
      license = licenses.unfree;
      platforms = platforms.all;
    };
  }
  ''
    7z e -y -o$TMPDIR ${iso} sources/install.wim
    mkdir -p $out/share/fonts/truetype
    wimextract $TMPDIR/install.wim 1 Windows/Fonts \
      --dest-dir=$TMPDIR/wim --no-acls --no-attributes
    cd $TMPDIR/wim/Fonts
    cp msyhbd.ttc msyhl.ttc msyh.ttc simsunb.ttf simsun.ttc \
      $out/share/fonts/truetype/
  ''
