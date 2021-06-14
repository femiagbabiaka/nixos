{ config, lib, pkgs, nixosConfig, ... }:

let
  commitTemplate = with nixosConfig.femi.git;
    pkgs.writeTextFile  {
      name = "femi-commit-template";
      text = ''


        Signed-off-by: ${name} <${email}>
      '';
    };
in {
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = nixosConfig.femi.git.name;
    userEmail = nixosConfig.femi.git.email;
    ignores = [ "*~" "*.swp" "*.#" ];
    delta.enable = true;
    extraConfig = {
      commit.template = "${commitTemplate}";
      core.editor = "vim";
      color.ui = "auto";
      format.signoff = true;
      init.defaultBranch = "main";
      protocol.keybase.allow = "always";
      pull.rebase = "true";
      push.default = "current";

      url = {
        "git@github.com:".insteadOf = "https://github.com/";
      };
    };
  };
}
