{
  description = "ROS Humble DevShell Flake";

  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs"; # IMPORTANT!!!
  };
  outputs =
    {
      self,
      nix-ros-overlay,
      nixpkgs,
    }:
    nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-ros-overlay.overlays.default ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "ROS2-Humble";
          shell = pkgs.zsh;

          packages = [
            pkgs.colcon
            # pkgs.pythonPackagesExtensions
            # ... other non-ROS packages
            (
              with pkgs.rosPackages.humble;
              buildEnv {
                paths = [
                  ros-core
                  desktop
                  std-msgs
                  sensor-msgs
                  geometry-msgs
                  nav-msgs
                  visualization-msgs
                  tf2-msgs
                  rclcpp
                  # ... other ROS packages
                ];
              }
            )
          ];
        };
      }
    );
  nixConfig = {
    extra-substituters = [ "https://ros.cachix.org" ];
    extra-trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
  };
}
