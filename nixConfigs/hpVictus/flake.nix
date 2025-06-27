{
  description = "My Modular NixOS i3 and sway config with Home Manager 25.05";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {

      sway-nouveau = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/sway-nouveau.nix
          home-manager.nixosModules.home-manager
        ];
      };

      i3-nvidia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/i3-nvidia.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}

