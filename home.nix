{ inputs, config, pkgs, pkgs-unstable, ... }:

let
  adwaita-slim-dark-gtk-theme = import ./pkgs/adwaita-slim-dark-gtk-theme.nix { inherit pkgs; };
  cursorTheme = "Bibata-Modern-Ice";
in
{
  home.username = "harry";
  home.homeDirectory = "/home/harry";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "SpaceMono" ]; })
    inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
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
    pkgs.hyprshade
    pkgs.fzf

    inputs.zen-browser.packages.${pkgs.system}.beta
    pkgs.pcmanfm

    pkgs.keepassxc
    pkgs.nwg-look

    pkgs.openspades
    pkgs.doomrunner
    pkgs.gzdoom
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim" = {
      source = inputs.nvim-config;
      recursive = true;
    };

    ".config/hyprshade".source = ./dotfiles/hyprshade;

    ".config/tmux".source = ./dotfiles/tmux;
    ".config/satty".source = ./dotfiles/satty;

    ".config/rofi/theme.rasi".source = ./dotfiles/rofi/theme.rasi;
    ".config/rofi/background.jpg".source = ./dotfiles/rofi/background.jpg;

    ".config/hypr/wallpaper.png".source = ./assets/space-pixel.png;
    ".local/share/openspades".source = ./dotfiles/openspades;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      hms = "home-manager switch";
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
    # HISTSIZE = 10000;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.udiskie.enable = true;

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.clipse}/bin/clipse -listen"
        "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular"
        "${pkgs.avizo}/bin/avizo-service"
        "${pkgs.hyprland}/bin/hyprctl setcursor ${cursorTheme} 24"
        # For hyprshade scheduling
        "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE"
        "${pkgs.hyprshade}/bin/hyprshade auto"
      ];
      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = "rgba(7AA2F7ff)";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "master";
      };
      decoration = {
        blur = {
          enabled = false;
          size = 6;
          passes = 1;
          new_optimizations = true;
        };
        rounding = 1;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1";
        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
	      "border, 1, 10, default"
	      "borderangle, 1, 8, default"
	      "fade, 1, 7, default"
	      "workspaces, 1, 4, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
      	new_on_top = true;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 100;
      };
      input = {
        kb_layout = "latam";
        repeat_delay = 300;
        repeat_rate = 50;
      };
      windowrulev2 = [
        "float, class:clipse"
        "noborder, fullscreen:1"
      ];
      workspace = [
        "1, monitor:eDP-1"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1"
      ];
      "$mainMod" = "ALT";
      bind = [
        "$mainMod, W, killactive,"
        "$mainMod SHIFT, M, exit,"
	    "$mainMod, V, togglefloating,"
	    "$mainMod, F, fullscreen, 1"
	    "$mainMod SHIFT, F, fullscreen"
	    "$mainMod, A, layoutmsg, orientationnext"
	    "$mainMod, P, pseudo,"
	    "$mainMod SHIFT, J, togglesplit,"

	    "$mainMod, 1, workspace, 1"
	    "$mainMod, 2, workspace, 2"
	    "$mainMod, 3, workspace, 3"
	    "$mainMod, 4, workspace, 4"
	    "$mainMod, 5, workspace, 5"
	    "$mainMod, 6, workspace, 6"
	    "$mainMod, 7, workspace, 7"
	    "$mainMod, 8, workspace, 8"
	    "$mainMod, 9, workspace, 9"
	    "$mainMod, 0, workspace, 10"

	    "$mainMod Control_R, 1, workspace, 6"
	    "$mainMod Control_R, 2, workspace, 7"
	    "$mainMod Control_R, 3, workspace, 8"
	    "$mainMod Control_R, 4, workspace, 9"
	    "$mainMod Control_R, 5, workspace, 10"

	    "$mainMod SHIFT, 1, movetoworkspace, 1"
	    "$mainMod SHIFT, 2, movetoworkspace, 2"
	    "$mainMod SHIFT, 3, movetoworkspace, 3"
	    "$mainMod SHIFT, 4, movetoworkspace, 4"
	    "$mainMod SHIFT, 5, movetoworkspace, 5"
	    "$mainMod SHIFT, 6, movetoworkspace, 6"
	    "$mainMod SHIFT, 7, movetoworkspace, 7"
	    "$mainMod SHIFT, 8, movetoworkspace, 8"
	    "$mainMod SHIFT, 9, movetoworkspace, 9"
	    "$mainMod SHIFT, 0, movetoworkspace, 10"

	    "$mainMod, mouse_down, workspace, e+1"
	    "$mainMod, mouse_up, workspace, e-1"

	    "$mainMod, h, movefocus, l"
	    "$mainMod, l, movefocus, r"
	    "$mainMod, k, movefocus, u"
	    "$mainMod, j, movefocus, d"

	    "$mainMod SHIFT, left, movewindow, l"
	    "$mainMod SHIFT, right, movewindow, r"
	    "$mainMod SHIFT, up, movewindow, u"
	    "$mainMod SHIFT, down, movewindow, d"

        "$mainMod, Q, exec, alacritty"
	    "$mainMod, R, exec, rofi -show combi"
	    "$mainMod, C, exec, hyprpicker -af hex"
	    "$mainMod, Z, exec, alacritty --class clipse -e clipse"
	    '', Print, exec, grim -g "$(slurp -o -r -c '##ff0000ff')" -t ppm - | satty --filename -''

	    ", XF86AudioRaiseVolume, exec, volumectl -u up"
	    ", XF86AudioLowerVolume, exec, volumectl -u down"
	    ", XF86AudioMute, exec, volumectl toggle-mute"
	    ", XF86AudioMicMute, exec, volumectl -m toggle-mute"

	    ", XF86AudioPlay, exec, playerctl play-pause"
	    ", XF86AudioStop, exec, playerctl stop"
	    ", XF86AudioPrev, exec, playerctl previous"
	    ", XF86AudioNext, exec, playerctl next"

	    ", XF86MonBrightnessUp, exec, lightctl up 5"
	    ", XF86MonBrightnessDown, exec, lightctl down 5"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${config.xdg.configHome}/hypr/wallpaper.png"
      ];
      wallpaper = [
        ", ${config.xdg.configHome}/hypr/wallpaper.png"
      ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = cursorTheme;
    package = pkgs.bibata-cursors;
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
    };
    font = {
      name = "Adwaita Sans";
      package = pkgs-unstable.adwaita-fonts;
    };
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
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

  programs.rofi = {
    enable = true;
    font = "SpaceMono Nerd Font 12";
    theme = "./theme.rasi";
    extraConfig = {
      display-combi = "";
      combi-display-format = "{text}";
      modes = "drun,run,ssh,combi";
      show-icons = true;
      combi-modes = "drun,run";
      terminal = "alacritty";
    };
  };

  programs.git = {
    enable = true;
    userName = "Harrizon";
    userEmail = "harryalex0281@hotmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      go
      gotools
      deno
      dotnet-sdk
      unzip
      nodejs_23
      nodePackages_latest.live-server
    ];
  };

  programs.tmux.enable = true;

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
