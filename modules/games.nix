{ pkgs, pkgs-unstable, ... }:
{
  home.packages = [
    pkgs.openspades
    pkgs.doomrunner
    pkgs-unstable.uzdoom

    pkgs.duckstation
    (pkgs.retroarch.withCores (cores: with cores; [
      mame
      fbneo
      snes9x
      swanstation
      mesen
    ]))
    # pkgs.clonehero
    (pkgs.clonehero.overrideAttrs (previousAttrs: {
      version = "1.1.0.4261-PTB";
      src = pkgs.fetchurl {
        url = "https://github.com/clonehero-game/releases/releases/download/v1.1.0.4261-PTB/clonehero-linux.tar.xz";
        hash = "sha256-Yfbd8TqTZ0IYxMIY5TmsxTfD/Bz/anV0dgP1v13ders=";
      };
    }))
  ];

  home.file = {
    ".local/share/openspades".source = ./dotfiles/openspades;
    ".config/gzdoom/gzdoom.ini".source = ./dotfiles/gzdoom/gzdoom.ini;
  };
}
