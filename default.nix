# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> {} }:

let
  kalbasitRepo = import (builtins.fetchTarball https://github.com/kalbasit/nur-packages/tarball/master) {
    inherit pkgs;
  };
in rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  gatsby-cli = pkgs.callPackage ./pkgs/gatsby-cli {};
  romkatv-gitstatus = pkgs.callPackage ./pkgs/powerlevel10k/romkatv-gitstatus.nix {};
  powerlevel10k = pkgs.callPackage ./pkgs/powerlevel10k { gitstatus = romkatv-gitstatus; };
  nixify = kalbasitRepo.nixify;
}

