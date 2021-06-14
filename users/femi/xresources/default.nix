{ config, lib, pkgs, ... }:

{
  xresources.properties = {
    "xterm*font" = "xft:Go Mono for Powerline:size=12";
    "URxvt*font" = "xft:Go Mono for Powerline:size=12";
    # extensions i use
    "URxvt.perl-ext-common" = "default,clipboard,matcher,tabbedex,vtwheel";

    # transparency
    "URxvt*depth" = "32";

    # URL opening
    "URxvt.url-launcher" = "${pkgs.xdg_utils}/bin/xdg-open";
    "URxvt.keysym.C-Delete" = "perl:matcher:last";
    "URxvt.keysym.M-Delete" = "perl:matcher:list";
    "URxvt.matcher.button" = "1";

    # Tabs
    "URxvt.tabbedex.autohide" = "false";
    "URxvt.tabbedex.reopen-on-close" = "no";
    "URxvt.keysym.Control-t" = "perl:tabbedex:new_tab";
    "URxvt.keysym.Control-Tab" = "perl:tabbedex:next_tab";
    "URxvt.keysym.Control-Shift-Tab" = "perl:tabbedex:prev_tab";
    "URxvt.keysym.Control-Shift-Left" = "perl:tabbedex:move_tab_left";
    "URxvt.keysym.Control-Shift-Right" = "perl:tabbedex:move_tab_right";
    "URxvt.keysym.Control-Shift-R" = "perl:tabbedex:rename_tab";
    "URxvt.tabbedex.no-tabbedex-keys" = "true";
    "URxvt.tabbedex.new-button" = "yes";

    # Clipboard
    "URxvt.clipboard.autocopy" = "true";
    "URxvt.keysym.Shift-M-C" = "perl:clipboard:copy";
    "URxvt.keysym.Shift-M-V" = "perl:clipboard:paste";

    # Hacks
    "URxvt*skipBuiltinGlyphs" = "true";
    "URxvt.scrollBar" = "false";
    "URxvt.iso14755" = "false";
    "URxvt.iso14755_52" = "false";
    "URxvt.geometry" = "100x50";
    "URxvt.depth" = "32";
    "URxvt.background" = "[95]#32302f";
  };

  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "solarized";
      repo = "xresources";
      rev = "025ceddbddf55f2eb4ab40b05889148aab9699fc";
      sha256 = "0lxv37gmh38y9d3l8nbnsm1mskcv10g3i83j0kac0a2qmypv1k9f";
    } + "/Xresources.dark"
  );
}
