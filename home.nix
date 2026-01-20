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
    ./modules/hyprland.nix
    ./modules/theme.nix
    ./modules/rofi.nix
    ./modules/quickshell.nix
    ./modules/alacritty.nix
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

    pkgs.wl-clip-persist
    pkgs.wl-clipboard
    pkgs.clipse

    pkgs.slurp
    pkgs.grim
    pkgs.satty

    pkgs.playerctl
    pkgs.brillo
    pkgs.hyprpicker
    pkgs.fzf
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

    ".config/satty".source = ./dotfiles/satty;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      hms = "home-manager switch";
      cddata = "cd /media/data/";
      cddocente = "cd /media/data/docente/";
      cddev = "cd /home/harry/dev/";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    };
    bashrcExtra = ''
      shopt -s histappend # When you exit a shell, the history from that session is appended
      eval "$(fzf --bash)" # fzf Ctrl+R

      # If not running interactively, don't do anything
      [[ $- != *i* ]] && return

      PS1=' \W\[\e[0;38;5;12m\] > \[\e[0m\]'
    '';
    historySize = 10000;
  };

  home.sessionVariables = {
    HISTCONTROL = "erasedups";
    EDITOR = "hx";
    BROWSER = "zen";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.udiskie.enable = true;

  # discoverable fonts
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.sioyek = {
    enable = true;
    config = {
      # Can open multiple instances
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

  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language = [
        {
          name = "typst";
          auto-format = true;
          formatter.command = "typstyle";
        }
      ];
      language-server.texlab = {
        config.texlab = {
          chktex = {
            onOpenAndSave = true;
            onEdit = true;
          };
          forwardSearch = {
            executable = "sioyek";
            args = [ "--inverse-search" "%l:%c:%f" "%p" ];
          };
          build = {
            auxDirectory = "build";
            logDirectory = "build";
            pdfDirectory = "build";

            forwardSearchAfter = true;
            onSave = true;

            executable = "latexmk";
            args = [
              "-pdf"
              "-interaction=nonstopmode"
              "-synctex=0"
              "-shell-escape"
              "-output-directory=build"
              "%f"
            ];
          };
        };
      };
    };
    settings = {
  	  theme = "nord";
  	  editor = {
        lsp.auto-signature-help = false;
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };
  	    soft-wrap = {
  	      enable = true;
  	      max-wrap = 25;
  	      wrap-indicator = "";
  	    };
  	    cursor-shape = {
  	      insert = "bar";
  	      normal = "block";
  	      select = "underline";
  	    };
  	  };
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

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
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
