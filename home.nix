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
    ./modules/theme.nix
    ./modules/rofi.nix
    ./modules/quickshell.nix
    ./modules/alacritty.nix
    ./modules/helix.nix
    ./modules/tmux.nix
    ./modules/music.nix
    ./modules/games.nix
  ];

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
    pkgs.font-manager

    pkgs.pavucontrol
    pkgs.unzip
    pkgs.nix-search-tv
    pkgs.tree
    pkgs.libqalculate
    pkgs.nmgui

    inputs.zen-browser.packages.${pkgs.system}.beta
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

    pkgs-unstable.yaak
    pkgs-unstable.dbgate
    pkgs.arduino-ide
    pkgs.xh
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/harry/.config/home-manager/dotfiles/nvim";
  };

  home.sessionVariables = {
    HISTCONTROL = "erasedups";
    BROWSER = "zen";
  };

  programs.home-manager.enable = true;

  services.udiskie.enable = true;

  # discoverable fonts
  fonts.fontconfig.enable = true;

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
