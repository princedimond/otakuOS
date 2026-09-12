{ ... }:
{
  flake.modules.nixos.dev =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfreePackages = [

      ];
      environment.systemPackages = with pkgs; [
        luaformatter
        lua-language-server
        nil
        vscode-langservers-extracted
        bash-language-server
        awk-language-server
        vscode-extensions.llvm-vs-code-extensions.vscode-clangd
        clang-tools
        #nixd #additional language server / replacement for nil
        marksman
        nixfmt
        meld
        gh
      ];
    };

}
