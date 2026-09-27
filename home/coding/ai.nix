{ pkgs, inputs, ... }:
let
  llm-agents-pkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  dsh = llm-agents-pkgs.dsh;
  dshWithPnpm = dsh.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      sed -i '2i export PATH="${pkgs.lib.makeBinPath [ pkgs.pnpm ]}:$PATH"' $out/bin/dsh
    '';
  });
in
{
  home.packages = with pkgs; [
    opencode
    cc-switch
    dshWithPnpm
    # ai tool
    ripwire
  ];
}
