{ ... }:
{
  flake.modules.nixos.zsh =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nh
        rsync
        zsh-autosuggestions
      ];

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        shellInit = ''
          zsh-newuser-install() { :; }
        '';

        promptInit = "
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
      ";

        shellAliases = {
          fuck = "pay-respects";
          fr = "`nh os switch \"path:/otakuOS\" --ask";
          fbr = "nh os boot \"path:/otakuOS\" --ask";
          fu = "nh os switch \"path:/otakuOS\" --ask --update";
          fbu = "nh os boot \"path:/otakuOS\" --ask --update";
          fclean = "nh clean all --keep 4 --keep-since 24h --ask";
          copy = "rsync -azvhH --info=progress2";
        };
        histSize = 10000;

      };
    };
}
