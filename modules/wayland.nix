{ inputs, pkgs, ... }:
{
  home.packages = [
    pkgs.wl-clip-persist
    pkgs.wl-clipboard
    # clipboard history
    pkgs.clipse

    # to take screenshots
    pkgs.slurp
    pkgs.grim
    pkgs.satty

    pkgs.brillo
  ];

  home.file = {
    ".config/satty".source = ./dotfiles/satty;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };
    mimeApps = {
      enable = true;
      defaultApplications = mimeAssociations;
    };
    configFile."mimeapps.list".force = true;
  };

  services.avizo = {
    enable = true;
    package = pkgs.avizo.overrideAttrs (previousAttrs: {
      src = inputs.avizo-brillo;
    });
    settings = {
      default = {
        time = 1.5;
      	image-opacity = 1;
      	width = 150;
      	height = 150;
      	padding = 20;
      	y-offset = 0.9;
      	border-radius = 16;
      	block-height = 7;
      	block-spacing = 2;
      	block-count = 16;
      	fade-in = 0.5;
      	fade-out = 0.5;
      };
    };
  };
}
