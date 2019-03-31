{ stdenv, pkgs }:

let
  extraNodePackages = import ./node-composite.nix {
    inherit pkgs;
    system = stdenv.system;
  };

  asciidoctor-core = extraNodePackages."@asciidoctor/core";
  asciidoctor-cli = extraNodePackages."@asciidoctor/cli".override {
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postFixup = ''
      wrapProgram $out/bin/asciidoctor \
        --set NODE_PATH "${asciidoctor-core}/lib/node_modules"
      wrapProgram $out/bin/asciidoctorjs \
        --set NODE_PATH "${asciidoctor-core}/lib/node_modules"
    '';
  };
  asciidoctor = pkgs.buildEnv {
    name = "asciidoctor-${asciidoctor-core.version}";
    paths = [
      asciidoctor-core
      asciidoctor-cli
    ];
  };
in {
  inherit asciidoctor;
  inherit (extraNodePackages) gatsby-cli react-static;
}