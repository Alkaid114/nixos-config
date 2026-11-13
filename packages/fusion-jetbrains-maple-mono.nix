{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "fusion-jetbrains-maple-mono";
  version = "1.2304.78"; # nb，同一个版本天天触发github action哈希还能变的，那就只能用上一个旧版本了

  src = fetchurl {
    url = "https://github.com/SpaceTimee/Fusion-JetBrainsMapleMono/releases/download/${finalAttrs.version}/JetBrainsMapleMono-NF-NR-XX.zip";
    sha256 = "sha256-tPI9dUcHe4eGAF3+4OSIrnsiUkFAlAG4qUGBaBSkJ6g=";
  };

  nativeBuildInputs = [ unzip ];

  unpackPhase = ''
    runHook preUnpack
    mkdir -p font-files
    unzip -o $src -d font-files
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts
    find font-files -type f \( -name '*.ttf' -o -name '*.otf' \) -exec cp {} $out/share/fonts/ \;
    runHook postInstall
  '';

  meta = {
    description = "JetBrains Mono fused with Maple Mono for perfect CJK support";
    homepage = "https://github.com/SpaceTimee/Fusion-JetBrainsMapleMono";
    license = lib.licenses.ofl11;
    platforms = lib.platforms.all;
  };
})
