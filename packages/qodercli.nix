{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

let
  version = "1.1.80";

  sources = {
    x86_64-linux = {
      url = "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/${version}/qodercli-linux-x64.tar.gz";
      hash = "sha256-VsLRULQJbi1DErcPeP0IcT+lAskTUuRYWKYzAjPQQwQ=";
    };
    aarch64-linux = {
      url = "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/${version}/qodercli-linux-arm64.tar.gz";
      hash = "sha256-DHAfiN0Ma0FKtQKhdfX66U4HhhP98FHFPbEX6CcspTk=";
    };
    x86_64-darwin = {
      url = "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/${version}/qodercli-darwin-x64.tar.gz";
      hash = "sha256-gQADuDoz4V3fMi1x2EaPBc6C1OEcW3/xS+1yB2g8lkk=";
    };
    aarch64-darwin = {
      url = "https://qoder-ide.oss-accelerate.aliyuncs.com/qodercli/releases/${version}/qodercli-darwin-arm64.tar.gz";
      hash = "sha256-lGyCXbUuoRHW2g/nfAoDWJ/QKx2tvNjkDrr1ugPpQGo=";
    };
  };

  source =
    sources.${stdenv.hostPlatform.system}
      or (throw "qodercli: unsupported platform ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "qodercli";
  inherit version;

  src = fetchurl { inherit (source) url hash; };

  nativeBuildInputs = [ autoPatchelfHook ];

  sourceRoot = ".";

  # The upstream archive is a single Bun-compiled executable; there is nothing
  # to build, and stripping could damage the embedded script payload.
  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 qodercli $out/bin/qodercli
    runHook postInstall
  '';

  meta = {
    description = "Qoder CLI, an AI coding agent for the terminal";
    homepage = "https://qoder.com";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    license = lib.licenses.unfree;
    mainProgram = "qodercli";
    platforms = builtins.attrNames sources;
  };
}
