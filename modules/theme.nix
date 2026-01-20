{ pkgs, lib, config, ... }:
let
  adwaita-slim-dark-gtk-theme = import ./pkgs/adwaita-slim-dark-gtk-theme.nix { inherit pkgs; };
in
{
  options.theme = {
    cursorTheme = lib.mkOption {
      type = lib.types.str;
      default = "Bibata-Modern-Ice";
    };

    cursorSize = lib.mkOption {
      type = lib.types.int;
      default = 20;
    };
  };
  
  config = {
    home.pointerCursor = {
      gtk.enable = true;
      name = config.theme.cursorTheme;
      package = pkgs.bibata-cursors;
      size = config.theme.cursorSize;
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-Slim-Dark";
        package = adwaita-slim-dark-gtk-theme;
      };
      cursorTheme = {
        name = config.theme.cursorTheme;
        package = pkgs.bibata-cursors;
        size = config.theme.cursorSize;
      };
      font = {
        name = "Adwaita Sans";
        package = pkgs.adwaita-fonts;
      };
      iconTheme = {
        name = "kora";
        package = pkgs.kora-icon-theme;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };
  };
}
