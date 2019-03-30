{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  gatsby-cli = (import ./node-composite.nix {
    inherit pkgs;
    system = stdenv.system;
  }).gatsby-cli;
  nodePackages = nodePackages_10_x;
in mkShell {
  buildInputs = [
    nodePackages.yarn
    nodejs-10_x
    gatsby-cli
  ];
}
