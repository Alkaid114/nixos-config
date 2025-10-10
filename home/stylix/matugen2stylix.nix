{
  lib ? import <nixpkgs/lib>,
  jsonPath,
  variant ? "dark",
}:

let
  matugenJson = builtins.fromJSON (builtins.readFile jsonPath);
  colors = matugenJson.colors.${variant};
in
{
  name = "matugen-${variant}";
  base00 = colors.surface;
  base01 = colors.surface_container_low;
  base02 = colors.surface_container_high;
  base03 = colors.outline_variant;
  base04 = colors.on_surface_variant;
  base05 = colors.on_surface;
  base06 = colors.on_background;
  base07 = colors.inverse_surface;
  base08 = colors.error;
  base09 = colors.tertiary;
  base0A = colors.secondary;
  base0B = colors.primary;
  base0C = colors.on_primary_container;
  base0D = colors.on_secondary_container;
  base0E = colors.on_tertiary_container;
  base0F = colors.error_container;
}
