{
  description = "Alkaid's NixOS flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-25.05/nixexprs.tar.xz";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # plasma-manager = {
    #   url = "github:nix-community/plasma-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };
  };

 outputs = { self, nixpkgs, home-manager, ... }@inputs: 
 let 
  mkHost = 
    {hostname, username}:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inputs = inputs;
            hostname = hostname;
          };
          modules = [
            ./hosts/${hostname}
            ./users/${username}/system.nix
            ./common/system.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${username} = import ./users/${username}/home.nix;
              
              # home-manager.extraSpecialArgs = {
              #   # inherit (inputs) plasma-manager;
              #   inherit username;
              #   inherit hostname;
              # };
            }
          ];
        };
in
 {
    nixosConfigurations = {
      alkaid-qemu = mkHost {hostname="alkaid-qemu";username="alkaid"};
      asus-rtx4060 = mkHost {hostname="asus-rtx4060";username="alkaid"};
    }
 };
}