{
  pkgs,
  yamlPath,
  ...
}:
let
  json = builtins.fromJSON (
    builtins.readFile (
      pkgs.runCommand "yaml-to-json"
        {
          buildInputs = [ pkgs.yj ];
        }
        ''
          yj -y -j < ${yamlPath} > $out
        ''
    )
  );
in
{
  name = json.scheme or "Unnamed";
  author = json.author or "Unknown";

  base00 = "#" + json.base00;
  base01 = "#" + json.base01;
  base02 = "#" + json.base02;
  base03 = "#" + json.base03;
  base04 = "#" + json.base04;
  base05 = "#" + json.base05;
  base06 = "#" + json.base06;
  base07 = "#" + json.base07;
  base08 = "#" + json.base08;
  base09 = "#" + json.base09;
  base0A = "#" + json.base0A;
  base0B = "#" + json.base0B;
  base0C = "#" + json.base0C;
  base0D = "#" + json.base0D;
  base0E = "#" + json.base0E;
  base0F = "#" + json.base0F;
}
