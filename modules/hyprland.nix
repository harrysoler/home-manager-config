{ lib, inputs, config, pkgs, ... }: 
{
  options = {
    hyprland.cursorTheme = lib.mkOption {
      type = lib.types.str;
    };

    hyprland.cursorSize = lib.mkOption {
      type = lib.types.int;
    };
  };

  config = {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ]; 
    };

    home.packages = [
      pkgs.hyprpicker
      pkgs.playerctl
    ];

    home.sessionVariables = {
      HYPRCURSOR_THEME = config.hyprland.cursorTheme;
      HYPRCURSOR_SIZE = config.hyprland.cursorSize;
      GDK_SCALE = 1.2;
    };

    home.file = {
      ".config/hypr/wallpaper.png".source = ../assets/a10.png;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [
          "${pkgs.hyprpaper}/bin/hyprpaper"
          "${pkgs.clipse}/bin/clipse -listen"
          "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular"
          "${pkgs.avizo}/bin/avizo-service"
          "${pkgs.gammastep}/bin/gammastep -l 5.526096748847994:-73.36712121379337 -t 6500:3500"
          "${inputs.quickshell.packages.${pkgs.system}.default}/bin/quickshell"
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
            enabled = true;
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
        gesture = [
          "3, horizontal, workspace"
          "3, up, fullscreen"
          "3, down, float"
          "3, swipe, mod: SUPER, resize"
        ];
        input = {
          kb_model="pc104awide";
          kb_layout = "us";
          kb_variant = "altgr-intl,colemak_dh_wide";
          kb_options = "grp:win_space_toggle,misc:extend,lv5:caps_switch_lock,compose:menu";
          repeat_delay = 200;
          repeat_rate = 40;
        };
        windowrulev2 = [
          "float, class:clipse"
          "float, class:testgui"
          "noborder, fullscreen:1"
          "fullscreen, class:openspades"
          "maximize, class:openspades"

          "bordercolor rgba(7AF77FAA), pinned:1"
        ];
        xwayland = {
          force_zero_scaling = true;
        };
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
        monitor = [
          "eDP-1,1920x1080@60,0x0,1.2"
        ];
        "$mainMod" = "WIN";
        bind = [
          "$mainMod SHIFT, M, exit,"
          "$mainMod, W, killactive,"
          "$mainMod, V, togglefloating,"
          "$mainMod, F, fullscreen, 1"
          "$mainMod SHIFT, F, fullscreen"
          "$mainMod, A, layoutmsg, orientationnext"
          "$mainMod SHIFT, J, togglesplit,"
          "$mainMod, P, pin,"

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
          "$mainMod, S, exec, rofi -show combi"
          "$mainMod, C, exec, hyprpicker -af hex"
          "$mainMod, Z, exec, alacritty --class clipse -e clipse"
          '', Print, exec, grim -g "$(slurp -o -r)" -t ppm - | satty --filename -''

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
  };
}
