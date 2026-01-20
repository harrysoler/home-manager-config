{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
  ];

  home.sessionVariables = {
    TERMINAL = "alacritty";
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
}
