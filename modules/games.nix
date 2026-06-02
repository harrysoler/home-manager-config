{ pkgs, lib, pkgs-unstable, inputs, ... }:
{
  home.packages = [
    pkgs.protonup-rs 

    inputs.zerospades.packages.${pkgs.stdenv.hostPlatform.system}.zerospades
    pkgs.openspades
    pkgs.doomrunner
    pkgs-unstable.uzdoom

    pkgs-unstable.wivrn

    pkgs-unstable.faugus-launcher
    pkgs.goverlay
    pkgs.vulkan-tools

    (pkgs.retroarch.withCores (cores: with cores; [
      mame
      fbneo
      snes9x
      swanstation
      mesen
      genesis-plus-gx
    ]))

    pkgs.clonehero
    # (pkgs.clonehero.overrideAttrs (previousAttrs: {
    #   version = "1.1.0.4261-PTB";
    #   src = pkgs.fetchurl {
    #     url = "https://github.com/clonehero-game/releases/releases/download/v1.1.0.4261-PTB/clonehero-linux.tar.xz";
    #     hash = "sha256-Yfbd8TqTZ0IYxMIY5TmsxTfD/Bz/anV0dgP1v13ders=";
    #   };
    # }))

    pkgs-unstable.protontricks
    pkgs.gamescope
    pkgs.gamescope-wsi
  ];

  xdg.desktopEntries."zerospades" = {
    name = "ZeroSpades";
    exec = "env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia gamescope -w 1920 -h 1080 -r 60 -- zerospades %U";
    terminal = false;
    categories = [ "ActionGame" "Game" ];
    mimeType = [ "x-scheme-handler/aos" ];
    icon = "zerospades";
    genericName = "Sandbox building and FPS videogame";
    comment = "Open-source clone of Ace of Spades";
    type = "Application";
  };

  home.file = {
    ".local/share/openspades/Resources/RifleUni.pak.bak".source = ./dotfiles/openspades/Resources/RifleUni.pak.bak;
    ".local/share/openspades/Resources/SPConfig.cfg".source = ./dotfiles/openspades/Resources/SPConfig.cfg;
    # ".config/gzdoom/gzdoom.ini".source = ./dotfiles/gzdoom/gzdoom.ini;
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

      # fps_limit = 60;
      fps_color_change = true;
      fps_color = "B22222,FDFD09,39F900";
      fps_value = "30,60";
    };
  };
}
