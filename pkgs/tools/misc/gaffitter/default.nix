{ stdenv, cmake, fetchurl }:

stdenv.mkDerivation rec {
  name = "gaffitter-${version}";
  version = "1.0.0";

  src = fetchurl {
    url = "mirror://sourceforge/gaffitter/gaffitter-${version}.tar.gz";
    sha256 = "c85d33bdc6c0875a7144b540a7cce3e78e7c23d2ead0489327625549c3ab23ee";
  };

  nativeBuildInputs = [ cmake ];

  buildPhase = ''
    cmake
    make
  '';

  meta = with stdenv.lib; {
    description = "Genetic Algorithm File Fitter";
    homepage = http://gaffitter.sourceforge.net/;
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ res0nat0r ];
  };
}
