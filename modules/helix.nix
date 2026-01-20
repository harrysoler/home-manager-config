{ ... }:
{
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language = [
        {
          name = "typst";
          auto-format = true;
          formatter.command = "typstyle";
        }
      ];
      language-server.texlab = {
        config.texlab = {
          chktex = {
            onOpenAndSave = true;
            onEdit = true;
          };
          forwardSearch = {
            executable = "sioyek";
            args = [ "--inverse-search" "%l:%c:%f" "%p" ];
          };
          build = {
            auxDirectory = "build";
            logDirectory = "build";
            pdfDirectory = "build";

            forwardSearchAfter = true;
            onSave = true;

            executable = "latexmk";
            args = [
              "-pdf"
              "-interaction=nonstopmode"
              "-synctex=0"
              "-shell-escape"
              "-output-directory=build"
              "%f"
            ];
          };
        };
      };
    };
    settings = {
  	  theme = "nord";
  	  editor = {
        lsp.auto-signature-help = false;
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };
  	    soft-wrap = {
  	      enable = true;
  	      max-wrap = 25;
  	      wrap-indicator = "";
  	    };
  	    cursor-shape = {
  	      insert = "bar";
  	      normal = "block";
  	      select = "underline";
  	    };
  	  };
    };
  };
}
