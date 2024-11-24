{
  description = "my second flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };

  outputs = inputs @ {
  self,
  nixpkgs,
  home-manager,
  hyprpanel, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ inputs.hyprpanel.overlay ];
        };
        modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      bartosz = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      };
    };

    extraSpecialArgs = {
      inherit system;
      inherit inputs;
    };
  };
}
