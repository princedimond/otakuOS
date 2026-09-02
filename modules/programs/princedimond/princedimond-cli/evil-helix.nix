{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        evil-helix
      ];
    };
    flake.modules.homeManager.princedimond-cli = {
      home.file.".config/helix/config.toml".text =
           ''
             theme = "catppuccin_mocha"
             #theme = "ao"

             [editor]
             evil = true
             end-of-line-diagnostics = "hint"
             auto-pairs = true
             mouse = true
             middle-click-paste = true
             shell = ["zsh", "-c"]
             line-number = "absolute"
             auto-completion = true
             path-completion = true
             auto-info = true
             color-modes = true
             popup-border = "all"
             clipboard-provider = "wayland"
             indent-heuristic = "hybrid"

             [editor.statusline]
             left = ["mode", "spinner"]
             center = ["file-absolute-path", "total-line-numbers", "read-only-indicator", "file-modification-indicator"]
             right = ["diagnostics", "selections", "position", "file-encoding", "file-line-ending", "file-type"]
             separator = "│"
             mode.normal = "NORMAL"
             mode.insert = "INSERT"
             mode.select = "SELECT"

             [editor.lsp]
             enable = true
             display-messages = true
             display-progress-messages = true

             [editor.inline-diagnostics]
             cursor-line = "hint"
             other-lines = "hint"
           '';

    };
}
