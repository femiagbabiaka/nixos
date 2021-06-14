{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.femi.urxvt;
in {
  options.femi.urxvt.enable =
    mkEnableOption "Enables urxvt as the default terminal";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rxvt-unicode
      urxvt_font_size
      urxvt_perl
      urxvt_tabbedex
      urxvt_vtwheel
    ];

    home.file."bin/term" = {
      executable = true;
      text = ''
        #!/bin/sh

        ${pkgs.xorg.xrdb}/bin/xrdb -merge ~/.Xresources

        ${pkgs.rxvt-unicode}/bin/urxvtc "$@"
        if [ $? -eq 2 ]; then
          ${pkgs.rxvt-unicode}/bin/urxvtd -q -o -f
          ${pkgs.rxvt-unicode}/bin/urxvtc "$@"
        fi
      '';
    };

    systemd.user.services = {
      urxvtd = {
        Unit = {
          Description = "Urxvt Terminal Daemon";
          Documentation = "man:urxvtd(1) man:urxvt(1)";
        };

        Service = { ExecStart = [ "${pkgs.rxvt-unicode}/bin/urxvtd -o -q" ]; };

        Install = { WantedBy = [ "default.target" ]; };
      };
    };
    systemd.user.startServices = true;
  };
}
