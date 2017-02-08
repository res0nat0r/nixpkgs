{stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "jdupes-${version}";
  version = "1.8";

  src = fetchurl {
    url = "https://github.com/jbruchon/jdupes/archive/v${version}.tar.gz";
    sha256 = "f2ba7cfecbc77cb2c43ec490994f3363754b6a84d6a5ca9728a2c33601acd6a0";
  };

  makeFlags = "PREFIX=\${out}";

  meta = {
    description = "A powerful duplicate file finder and an enhanced fork of 'fdupes'.";
    longDescription = ''
      jdupes is a program for identifying and taking actions upon duplicate
      files. This fork known as 'jdupes' is heavily modified from and improved
      over the original.
    '';
    homepage = "https://github.com/jbruchon/jdupes";
    license = stdenv.lib.licenses.mit;
  };
}
