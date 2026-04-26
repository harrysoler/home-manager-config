{ inputs, config, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
        picture-uri = "file:///home/harry/pictures/wallpapers/a10_portaaviones.png";
        picture-uri-dark = "file:///home/harry/pictures/wallpapers/a10_portaaviones.png";
      };
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = false;

      music = "/media/data/music";
      pictures = "${config.home.homeDirectory}/pictures";
      download = "${config.home.homeDirectory}/downloads";
      desktop = null;
      publicShare = null;
      templates = null;
      videos = null;
      documents = "/media/data/documents";
    };

    configFile."user-dirs.dirs".force = true;
  };
}
