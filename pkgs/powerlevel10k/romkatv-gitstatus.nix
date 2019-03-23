{ pkgs, stdenv, fetchFromGitHub }:

let 
  libgit2 = pkgs.callPackage ./romkatv-libgit2.nix {};
in stdenv.mkDerivation {
  name = "romkatv-gitstatus";
  src = fetchFromGitHub {
    owner = "romkatv";
    repo = "gitstatus";
    rev = "277a9908ede4c7b99b54d4f1fb37994777e4a1b5";
    sha256 = "0dsqbxl3s990675rscpnq2h0vnzh8vl1nmdkznbyh338as9vnyzi";
  };

  nativeBuildInputs = [ libgit2 ];

  preConfigure = ''
    export LDFLAGS="-static-libstdc++ -static-libgcc"
  '';

  installPhase = ''
    install -D gitstatusd -t $out/bin
  '';
}
