{ pkgs, pkgs-unstable, ... }:
with pkgs; let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (
    pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
      ${coreutils}/bin/mkdir -p $out/share/applications
      ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      '');
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in
{
  home.packages = [
    pkgs.protonup-rs 

    (GPUOffloadApp pkgs.openspades "openspades")
    (GPUOffloadApp pkgs.doomrunner "DoomRunner")
    (GPUOffloadApp pkgs-unstable.uzdoom "org.zdoom.UZDoom")
    (GPUOffloadApp pkgs-unstable.lutris-free "net.lutris.Lutris")

    (GPUOffloadApp pkgs.duckstation "org.duckstation.DuckStation")
    (GPUOffloadApp (pkgs.retroarch.withCores (cores: with cores; [
      mame
      fbneo
      snes9x
      swanstation
      mesen
      genesis-plus-gx
    ])) "com.libretro.RetroArch")

    # pkgs.clonehero
    (GPUOffloadApp (pkgs.clonehero.overrideAttrs (previousAttrs: {
      version = "1.1.0.4261-PTB";
      src = pkgs.fetchurl {
        url = "https://github.com/clonehero-game/releases/releases/download/v1.1.0.4261-PTB/clonehero-linux.tar.xz";
        hash = "sha256-Yfbd8TqTZ0IYxMIY5TmsxTfD/Bz/anV0dgP1v13ders=";
      };
    })) "clonehero")
  ];

  home.file = {
    ".local/share/openspades".source = ./dotfiles/openspades;
    ".config/gzdoom/gzdoom.ini".source = ./dotfiles/gzdoom/gzdoom.ini;
  };
}
