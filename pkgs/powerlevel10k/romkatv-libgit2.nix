{ cmake, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "romkatv-libgit2-8dbca9b";

  src = fetchFromGitHub {
    owner = "romkatv";
    repo = "libgit2";
    rev = "8dbca9b55da11c8ec1e83c64e08d96c48d482792";
    sha256 = "0bl3xzs2qp0n2zdbwmk5m3f2hx5xwhl086687zj415mchl9xirp3";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DTHREADSAFE=ON"
    "-DUSE_BUNDLED_ZLIB=ON"
    "-DUSE_ICONV=OFF"
    "-DBUILD_CLAR=OFF"
    "-DUSE_SSH=OFF"
    "-DUSE_HTTPS=OFF"
    "-DBUILD_SHARED_LIBS=OFF"
    "-DUSE_EXT_HTTP_PARSER=OFF"
  ];
}