{
  description = "please work";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    hyprpanel,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix ];
      };
    };

    homeConfigurations."bartosz@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.hyprpanel.overlay
        ];
      };
      modules = [ ./home.nix ];
      extraSpecialArgs = {
        inherit system;
        inherit inputs;
      };
    };
  };
}
