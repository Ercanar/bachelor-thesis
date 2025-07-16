{
  outputs = { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs.lib.fileset) toSource unions;
      in
      rec {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "pdf";

          src = toSource {
            root = ./.;
            fileset = unions [
              ./Thesis.typ
              ./img
              ./sources.bib
            ];
          };

          nativeBuildInputs = with pkgs; [ typst ];

          installPhase = ''
            mkdir -p $out
            for i in ./*.typ; do
              typst compile "$i" "$out/''${i%typ}pdf"
            done
          '';
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ packages.default ];

          shellHook = ''
            unset NIX_ENFORCE_NO_NATIVE
          '';

          env = {
            OMP_NUM_THREADS = 2;
            KMP_AFFINITY = "verbose,none";
          };

          packages = with pkgs; [
            (python312.withPackages (p: with p; [
              matplotlib
              numpy
            ]))

            gfortran
          ];
        };
      });
}
