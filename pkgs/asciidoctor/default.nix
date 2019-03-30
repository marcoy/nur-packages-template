{ pkgs ? import <nixpkgs> {} }:

with pkgs;

bundlerApp {
  pname = "asciidoctor";
  gemdir = ./.;
  exes = [ "asciidoctor" ];
}

