{ pkgs }:

let
  version = "26100.1.240331_1435-1";
  # Windows 11 24H2 LOF (Languages and Optional Features) ISO
  iso = pkgs.fetchurl {
    url = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1.240331-1435.ge_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso";
    hash = "sha256-/b2Hws1puoTvLqadW0aJODVdDWNLfeehmISA+UcTpzg=";
  };
in
pkgs.runCommand "ttf-ms-win11-fod-auto-hans-${version}" {
  outputHash = "sha256-DAQAZQLk69k6cUUN8mvXKXcs0Pbx4QrQ3jOJpKxWKp0=";
  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  nativeBuildInputs = [ pkgs.p7zip ];
  meta = with pkgs.lib; {
    description = "Microsoft Windows 11 Hans supplemental fonts (DengXian, SimHei, KaiTi, FangSong), extracted from the official ISO";
    license = licenses.unfree;
    platforms = platforms.all;
  };
} ''
  7z e -y -o$TMPDIR ${iso} \
    'LanguagesAndOptionalFeatures/Microsoft-Windows-LanguageFeatures-Fonts-Hans-Package~31bf3856ad364e35~amd64~~.cab'
  mkdir -p $out/share/fonts/truetype
  cd $out/share/fonts/truetype
  7z e -aoa \
    "$TMPDIR/Microsoft-Windows-LanguageFeatures-Fonts-Hans-Package~31bf3856ad364e35~amd64~~.cab" \
    '*/Dengb.ttf' '*/Dengl.ttf' '*/Deng.ttf' \
    '*/simfang.ttf' '*/simhei.ttf' '*/simkai.ttf'
''
