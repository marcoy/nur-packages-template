{ pkgs, stdenv }:

with pkgs;

let
  patchElfBin = "${patchelf}/bin/patchelf";
  dynamicLinker = stdenv.cc.bintools.dynamicLinker;
  setInterpreter = writeShellScriptBin "set-interpreter" ''
    exec ${patchElfBin} --set-interpreter '${dynamicLinker}' "$@"
  '';
in pkgs.buildEnv {
  name = "set-interpreter";
  paths = [ setInterpreter ];
  buildInputs = [ patchelf ];
}
