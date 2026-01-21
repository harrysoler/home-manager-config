{ pkgs, ... }:
{
  home.sessionVariables = {
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_DESKTOP = "sway";
  };

  home.file = {
    ".config/sway/config".source = ./dotfiles/sway/config;
    ".config/sway/wallpaper.png".source = ../assets/a10.png;
  };

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
        uiColor = "#7aa2f7ff";
        savePath = "/home/harry/pictures/screenshots";
        useGrimAdapter = true;
      };
    };
  };
}
