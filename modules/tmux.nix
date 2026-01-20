{ pkgs, ... }:
let
  customTmuxPlugins = import ./pkgs/custom-tmux-plugins.nix { inherit pkgs; };
in
{
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
}
