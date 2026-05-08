{ config, pkgs, pkgs-unstable, ... }:
{
  home.packages = [
    pkgs.protonup-rs 

    pkgs.openspades
    pkgs.doomrunner
    pkgs-unstable.uzdoom

    pkgs-unstable.wivrn

    pkgs-unstable.faugus-launcher
    pkgs.goverlay
    pkgs.vulkan-tools

    pkgs.duckstation
    (pkgs.retroarch.withCores (cores: with cores; [
      mame
      fbneo
      snes9x
      swanstation
      mesen
      genesis-plus-gx
    ]))

    # pkgs.clonehero
    (pkgs.clonehero.overrideAttrs (previousAttrs: {
      version = "1.1.0.4261-PTB";
      src = pkgs.fetchurl {
        url = "https://github.com/clonehero-game/releases/releases/download/v1.1.0.4261-PTB/clonehero-linux.tar.xz";
        hash = "sha256-Yfbd8TqTZ0IYxMIY5TmsxTfD/Bz/anV0dgP1v13ders=";
      };
    }))

    pkgs-unstable.protontricks
    pkgs.gamescope
    pkgs.gamescope-wsi
  ];

  home.file = {
    ".local/share/openspades".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/openspades;
    ".config/gzdoom/gzdoom.ini".source = ./dotfiles/gzdoom/gzdoom.ini;
  };

  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      legacy_layout = false;

      background_alpha = 0.6;
      round_corners = 0;
      background_color = "000000";

      font_size = 24;
      text_color = "FFFFFF";
      position = "top-left";

      pci_dev = "0:01:00.0";
      table_columns = 3;
      gpu_text = "GPU";
      gpu_stats = true;
      gpu_temp = true;
      gpu_color = "2E9762";
      cpu_text = "CPU";

      fps = true;
      fps_limit_method = "late";
      toggle_fps_limit = "Shift_L+F1";

      fps_limit = 60;
      fps_color_change = true;
      fps_color = "B22222,FDFD09,39F900";
      fps_value = "30,60";
    };
  };
}
