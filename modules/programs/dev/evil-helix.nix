{
  flake.modules.homeManager.dev = {
    home.file.".config/helix/languages.toml".text = ''
      [language-server.nil]
      command = "nil"

      [language-server.lua]
      command = "lua-language-server"

      [language-server.json]
      command = "vscode-json-languageserver"

      [language-server.markdown]
      command = "marksman"

    '';
  };
}
