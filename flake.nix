{
  description = "Home Manager configuration of harry";
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
    };

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    avizo-brillo.url = "github:harrysoler/avizo-brillo-support";
    avizo-brillo.flake = false;

    nvim-config.url = "github:harrysoler/nvim-config";
    nvim-config.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."harry" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;


        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
	extraSpecialArgs = {inherit inputs;};
      };
    };
}
