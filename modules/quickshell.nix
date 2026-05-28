{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.material-symbols
  ];

  home.file = {
    ".config/quickshell".source = ./dotfiles/quickshell;
    # uncomment if want hot reloading
    # ".config/quickshell".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/quickshell";
  };
}
