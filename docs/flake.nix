{
  description = "Latex for DFA/NFA Creation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      latexEnv = pkgs.texlive.combine {
        inherit (pkgs.texlive)
          scheme-small
          pgf
          ;
      };
    in
    {
      # Dev shell (if needed to debug)
      devShells.${system}.default = pkgs.mkShell {
        packages = [ latexEnv ];
        shellHook = ''
          echo "Entering LaTeX dev environment for DFA"
        '';
      };

      # Nix run to build DFA
      apps.${system}.default = {
        type = "app";
        program =
          (pkgs.writeShellApplication {
            name = "build-DFA";
            runtimeInputs = [ latexEnv ];
            text = ''
              mkdir -p ./log/
              pdflatex --jobname=Scanner-DFA --output-directory=./log/ DFA.tex
              mv -f ./log/Scanner-DFA.pdf ./
            '';
          })
          + "/bin/build-DFA";
      };
    };
}
