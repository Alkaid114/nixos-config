{ pkgs, ... }:
{
  home.packages = with pkgs; [
    opencode
    cc-switch
    # 手动 npm install --prefix ~/.local/share/dsh @deepseek-ai/dsh
    # 之后想个好点的办法
    (pkgs.writeShellApplication {
      name = "deepseek-harness";
      runtimeInputs = [ pkgs.nodejs_24 ];
      text = ''
        exec node --expose-internals \
          "$HOME/.local/share/dsh/node_modules/@deepseek-ai/dsh/lib/bin.js" \
          "$@"
      '';
    })
    # ai tool
    ripwire
  ];
}
