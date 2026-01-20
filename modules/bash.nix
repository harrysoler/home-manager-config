{ pkgs, ... }:
{
  home.packages = [
    pkgs.fzf
  ];

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
}
