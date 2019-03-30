{ stdenv, pkgs }:

with pkgs;

let
  gatsby-cli = (import ./node-composite.nix {
    inherit pkgs;
    system = stdenv.system;
  }).gatsby-cli;
  nodePackages = nodePackages_10_x;
in buildEnv {
  name = "gatsby-cli-env";
  paths = [
    nodePackages.yarn
    nodejs-10_x
    gatsby-cli
  ];
}
