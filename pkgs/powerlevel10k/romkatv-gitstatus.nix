{ pkgs, stdenv, fetchFromGitHub }:

let 
  libgit2 = pkgs.callPackage ./romkatv-libgit2.nix {};
in stdenv.mkDerivation {
  name = "romkatv-gitstatus";
  src = fetchFromGitHub {
    owner = "romkatv";
    repo = "gitstatus";
    rev = "2d469d2d7befe2cc7736e5a54ca484f0f27e33ba";
    sha256 = "170d79flly1hzyqcyfs9i2ij2njny1cqzirz87n1cinvaz7qyd5f";
  };

  nativeBuildInputs = [ libgit2 ];

  preConfigure = ''
    export LDFLAGS="-static-libstdc++ -static-libgcc"
  '';

  installPhase = ''
    install -D gitstatusd -t $out/bin
  '';
}
