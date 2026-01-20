{ pkgs, ... }:
{
  home.packages = [
    pkgs.adwaita-fonts
  ];

  home.file = {
    ".config/rofi/theme.rasi".source = ./dotfiles/rofi/theme.rasi;
    ".config/rofi/background.jpg".source = ./dotfiles/rofi/background.jpg;
  };
  
  programs.rofi = {
    enable = true;
    font = "Adwaita Sans 12";
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
}
