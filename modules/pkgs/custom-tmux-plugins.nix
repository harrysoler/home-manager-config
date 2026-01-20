{ pkgs }:

let
  mkTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
  fetchFromGitHub = pkgs.fetchFromGitHub;
in {
  tmuxifier = mkTmuxPlugin {
    pluginName = "tmuxifier";
    version = "0.13.0";
    src = fetchFromGitHub {
      owner = "jimeh";
      repo = "tmuxifier";
      rev = "9941b280635c7396b3cc6c15e92ea68a5cc24dd4";
      hash = "sha256-qF4a6+34xqBVKxtOyP2ze9qIvuRIEf1j2oXbd+h3TiM=";
    };
  };
  
  tmux-fzf = mkTmuxPlugin {
    pluginName = "tmux-fzf";
    version = "unstable";
    src = fetchFromGitHub {
      owner = "sainnhe";
      repo = "tmux-fzf";
      rev = "e91c1ae55389f2b34480ea23df77682bdd51d735";
      hash = "sha256-JItut2Iiuw8EEFCz6u7R1eLMxCvvPpSrQLkMbY+XXE8=";
    };
  };
}
