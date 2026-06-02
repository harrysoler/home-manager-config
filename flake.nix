{
  description = "Home Manager configuration of harry";
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zerospades.url = "github:zerospades/zerospades";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true;};
    in {
      homeConfigurations."harry" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;


        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
	    extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };
      };
    };
}
