{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      programs.zed-editor = {
        enable = true;
        extensions = [ "nix" ];

        userSettings = {
          git_panel = {
            dock = "right";
          };
          project_panel = {
            dock = "left";
          };
          tabs = {
            file_icons = true;
            git_status = false;
          };
          proxy = "";
          vim = {
            toggle_relative_line_numbers = false;
          };
          cli_default_open_behavior = "existing_window";
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          vim_mode = true;
          #icon_theme = "Zed (Default)";
          ui_font_size = 16;
          buffer_font_size = 15;
          /*
            theme = {
              mode = "dark";
              light = "Ayu Light";
              dark = "Ayu Dark";
            };
          */

          languages = {
            Nix = {
              language_servers = [ "nil" ];
              formatter = {
                external = {
                  command = "nixfmt";
                  arguments = [ ];
                };
              };
            };
          };
          lsp = {
            nil = {
              binary = {
                path = "${pkgs.nil}/bin/nil";
              };
            };
          };
        };
      };
    };
}
