{
  description = "My Machines";

inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  home-manager.url = "github:nix-community/home-manager/release-24.11";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
};

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.victus = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/default.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}

