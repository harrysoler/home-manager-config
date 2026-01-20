{ inputs, config, pkgs, pkgs-unstable, lib, ... }:

let
  adwaita-slim-dark-gtk-theme = import ./pkgs/adwaita-slim-dark-gtk-theme.nix { inherit pkgs; };
  customTmuxPlugins = import ./pkgs/custom-tmux-plugins.nix { inherit pkgs; };

  cursorTheme = "Bibata-Modern-Ice";
  cursorSize = 20;

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
    ./modules/rofi.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home.username = "harry";
  home.homeDirectory = "/home/harry";

  home.stateVersion = "24.11";

  home.packages = [
    pkgs.nerd-fonts.space-mono
    inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
    pkgs.hanken-grotesk
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

    inputs.quickshell.packages.${pkgs.system}.default
    pkgs.material-symbols

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

    pkgs.openspades
    pkgs.doomrunner
    pkgs.gzdoom
    pkgs.protonup-ng

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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/harry/.config/home-manager/dotfiles/nvim";

    ".config/satty".source = ./dotfiles/satty;

    # ".config/rofi/theme.rasi".source = ./dotfiles/rofi/theme.rasi;
    # ".config/rofi/background.jpg".source = ./dotfiles/rofi/background.jpg;

    ".config/hypr/wallpaper.png".source = ./assets/a10.png;
    ".local/share/openspades".source = ./dotfiles/openspades;

    ".config/quickshell".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/quickshell";

    ".config/gzdoom/gzdoom.ini".source = ./dotfiles/gzdoom/gzdoom.ini;
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
    HYPRCURSOR_THEME = cursorTheme;
    HYPRCURSOR_SIZE = cursorSize;
    EDITOR = "hx";
    BROWSER = "zen";
    TERMINAL = "alacritty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.udiskie.enable = true;

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = cursorTheme;
    package = pkgs.bibata-cursors;
    size = cursorSize;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-Slim-Dark";
      package = adwaita-slim-dark-gtk-theme;
    };
    cursorTheme = {
      name = cursorTheme;
      package = pkgs.bibata-cursors;
      size = cursorSize;
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

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dynamic_padding = true;
      	opacity = 0.8;
      };
      font = {
        normal.family = "SFMono Nerd Font";
        bold.family = "SFMono Nerd Font";
        italic.family = "SFMono Nerd Font";
        bold_italic.family = "SFMono Nerd Font";
        size = 12;
      };
      general = {
        live_config_reload = true;
      };
    };
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

  programs.tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.resurrect
        tmuxPlugins.vim-tmux-navigator
        customTmuxPlugins.tmuxifier
        customTmuxPlugins.tmux-fzf
      ];
      prefix = "C-a";
      mouse = true;
      extraConfig = "
        # Start windows and panes at 1, not 0
        set -g base-index 1
        setw -g pane-base-index 1

        # Correct colors
        set -ag terminal-overrides \",xterm-256color:RGB\"
        set -as terminal-features \",*:RGB\"

        # Split
        bind | split-window -h
        bind - split-window -v
        unbind '\"'
        unbind %

        # Tmuxifier
        bind P run-shell \"tmuxifier ls | fzf-tmux -p | xargs -I % sh -c 'tmuxifier s %; tmux switch-client -t %;'\"

        # Reload
        bind r source-file ~/.config/tmux/tmux.conf
        
        # Status bar
        set-option -g status-style fg=white,bg=default
        
        # Rename window auto
        set-option -g automatic-rename on
        
        set-option -g status-left ''
        set-option -g status-right '#(whoami)#(echo \" \")'
        
        set-option -g window-status-format '#(echo \" \")#{window_index}#(echo \":\")#{window_name}#(echo \" \")'
        # set-option -g window-status-current-format '#[bg=colour202,fg=colour232]#(echo \" \")#{window_index}#(echo \":\")#{window_name}#(echo \" \")'
        set-option -g window-status-current-format '#[fg=colour12]#(echo \" \")#{window_index}#(echo \":\")#{window_name}#(echo \" \")'
        
        set-option -g window-status-separator ''
        
        # border colours
        set -g pane-border-style fg=colour236
        set -g pane-active-border-style \"bg=default fg=colour12\"
      ";
  };
  programs.fzf.enable = true;

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

  services.mpd = {
    enable = true;
    musicDirectory = "/media/data/music";
    dataDir = "${config.xdg.configHome}/mpd";
    network.startWhenNeeded = true;
    extraConfig = ''
	max_output_buffer_size	"8192"
	audio_output {
		type		"pipewire"
		name		"pipewire output"
	}
    '';
  };

  services.mpd-mpris = {
      enable = true;
      mpd = {
          host = "localhost";
          port = 6600;
      };
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    settings = {
      visualizer_type = "spectrum";
      lyrics_directory = "${config.xdg.dataHome}/lyrics";
      message_delay_time = "2";
      browser_sort_mode = "format";
      browser_sort_format = "{%t - }|{%f - }{%a}";
      song_columns_list_format = "(30)[154]{t} (30)[154]{a} (30)[154]{b} (7)[154]{l}";
      song_status_format = "$b{{$8\"%t\"}} $3by {$4%a{ $3in $7%b{ (%y)}} $3}|{$8%f}";
      song_library_format = "{%n - }{%t}|{%f}";
      alternative_header_first_line_format = "$b{%t}|{%f}$/b";
      alternative_header_second_line_format = "{{$5$b%a$/b$9}{ - $5%b$9}}|{%f}";
      selected_item_prefix = "$6";
      selected_item_suffix = "$9";
      current_item_prefix = "$(cyan)$r$b";
      current_item_suffix = "$/r$(end)$/b";
      current_item_inactive_column_prefix = "$(magenta)$r";
      current_item_inactive_column_suffix = "$/r$(end)";
      now_playing_prefix = "$(154) » $9";
      now_playing_suffix = "";
      user_interface = "alternative";
      header_visibility = "no";
      statusbar_visibility = "no";
      titles_visibility = "yes";
      header_text_scrolling = "no";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      progressbar_look = "─╼";
      media_library_primary_tag = "album_artist";
      media_library_albums_split_by_date = "no";
      startup_screen = "browser";
      display_volume_level = "yes";
      ignore_leading_the = "yes";
      external_editor = "nvim";
      use_console_editor = "yes";
      empty_tag_color = "magenta";
      main_window_color = "white";
      allow_for_physical_item_deletion = "yes";
      progressbar_color = "black:b";
      progressbar_elapsed_color = "blue:b";
      statusbar_color = "red";
      statusbar_time_color = "cyan:b";
    };
  };
}
