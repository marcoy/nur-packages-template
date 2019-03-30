{ stdenv, pkgs }:

with pkgs;

let
  adocPackages = import ./node-composite.nix {
    inherit pkgs;
    system = stdenv.system;
  };
  nodePackages = nodePackages_10_x;

  asciidoctor-core = adocPackages."@asciidoctor/core";

  asciidoctor-cli = adocPackages."@asciidoctor/cli".override {
    nativeBuildInputs = [ makeWrapper ];

    postFixup = ''
      wrapProgram $out/bin/asciidoctor \
        --set NODE_PATH "${asciidoctor-core}/lib/node_modules"
      wrapProgram $out/bin/asciidoctorjs \
        --set NODE_PATH "${asciidoctor-core}/lib/node_modules"
    '';
  };
in buildEnv {
  name = "asciidoctor.js-2.0.0-rc1";
  paths = [
    asciidoctor-core
    asciidoctor-cli
  ];
}
