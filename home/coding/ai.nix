{ pkgs, inputs, ... }:
let
  llm-agents-pkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages =
    with pkgs;
    [
      opencode
      cc-switch
      # ai tool
      ripwire
    ]
    ++ (with llm-agents-pkgs; [
      dsh
    ]);
}
