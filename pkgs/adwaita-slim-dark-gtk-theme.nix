{ pkgs }:

let
  name = "Adwaita-Slim-Dark";
in
pkgs.stdenvNoCC.mkDerivation {
  name = "adwaita-slim-dark-gtk-theme";

  src = pkgs.fetchFromGitHub {
    owner = "archbyte";
    repo = "Adwaita-Slim";
    rev = "2b246dfbcf8b26783b7a8f974e5fb0a8fb2e4d0a";
    sha256 = "sha256-GpGr6HHliWAYt/1hII1S3jvpGzxA9fzHtZhjxQB4Fyg=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes/${name}/{gtk-3.0,gtk-4.0}
    cp -rv $src/* $out/share/themes/${name}/gtk-3.0/
    cp $src/{gtk.css,gtk-contained.css} $out/share/themes/${name}/gtk-4.0

    runHook postInstall
  '';
}
