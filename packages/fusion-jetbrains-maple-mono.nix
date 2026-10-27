{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "fusion-jetbrains-maple-mono";
  version = "1.2304.79";

  src = fetchurl {
    url = "https://github.com/SpaceTimee/Fusion-JetBrainsMapleMono/releases/download/${finalAttrs.version}/JetBrainsMapleMono-NF-NR-XX-XX.zip";
    sha256 = "sha256-CsWFGbCMDCuDXGgcEzQPiEwPWmwtK3IIjvXGLlGIarQ=";
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
