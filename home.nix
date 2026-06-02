{ inputs, config, pkgs, pkgs-unstable, lib, ... }:

let
  mimeAssociations = {
    "application/pdf" = "sioyek.desktop";
    "x-scheme-handler/http" = "zen-beta.desktop";
    "x-scheme-handler/https" = "zen-beta.desktop";
    "x-scheme-handler/chrome" = "zen-beta.desktop";
    "text/html" = "zen-beta.desktop";
    "application/x-extension-htm" = "zen-beta.desktop";
    "application/x-extension-html" = "zen-beta.desktop";
    "application/x-extension-shtml" = "zen-beta.desktop";
    "application/xhtml+xml" = "zen-beta.desktop";
    "application/x-extension-xhtml" = "zen-beta.desktop";
    "application/x-extension-xht" = "zen-beta.desktop";
    "image/jpeg" = "imv";
    "image/png" = "imv";
  };
in
{
  imports = [
    ./modules/bash.nix
    ./modules/wayland.nix
    ./modules/hyprland.nix
    # ./modules/sway.nix
    ./modules/gnome.nix
    ./modules/theme.nix
    ./modules/rofi.nix
    ./modules/quickshell.nix
    ./modules/alacritty.nix
    ./modules/helix.nix
    ./modules/tmux.nix
    ./modules/music.nix
    ./modules/games.nix
  ];

  wayland.mimeAssociations = mimeAssociations;

  hyprland = {
    cursorTheme = config.theme.cursorTheme;
    cursorSize = config.theme.cursorSize;
  };

  nixpkgs.config.allowUnfree = true;
  home.username = "harry";
  home.homeDirectory = "/home/harry";

  home.stateVersion = "24.11";

  home.packages = [
    # pkgs.nerd-fonts.space-mono
    # pkgs.hanken-grotesk
    pkgs.cozette
    pkgs.hanken-grotesk
    pkgs.font-manager

    pkgs.pavucontrol
    pkgs.nix-search-tv
    pkgs.tree
    pkgs.libqalculate
    pkgs.unar
    pkgs.btop-cuda

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta
    pkgs.qbittorrent
    pkgs.ungoogled-chromium
    pkgs.thunderbird
    pkgs.pcmanfm
    pkgs.libreoffice-still
    pkgs.xournalpp
    pkgs.localsend
    pkgs-unstable.gimp3
    pkgs.drawio
    pkgs.keepassxc
    pkgs.nwg-look
    pkgs.rnote
    pkgs.imv
    pkgs.mpv
    pkgs.beeref

    pkgs-unstable.yaak
    pkgs.lazysql
    pkgs.arduino-ide
    pkgs.xh
  ];

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/harry/.config/home-manager/modules/dotfiles/nvim";
  };

  home.sessionVariables = {
    BROWSER = "zen";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ]; 
  };

  programs.home-manager.enable = true;

  services.udiskie.enable = true;

  # discoverable fonts
  fonts.fontconfig.enable = true;

  # TODO
  # programs.opencode = {
  #   enable = true;
  #   settings = {
  #     provider = {
  #       npm = "@ai-sdk/openai-compatible";
  #       name = "llama-server (local)";
  #       options = {
  #         baseURL = "http://127.0.0.1:8080/v1";
  #       };
  #     };
  #     model = "qwen3.5-9B";
  #   };
  # };

  programs.sioyek = {
    enable = true;
    config = {
      # can open multiple instances
      should_launch_new_window = "1";
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Cozette:size=8";
      };
      colors = {
        alpha = 0.8;
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Harrizon";
        email = "harryalex0281@hotmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  programs.radicle = {
    enable = true;
    settings.node.alias = "harryalex";
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
        rust-analyzer
        lua-language-server
        gopls
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
