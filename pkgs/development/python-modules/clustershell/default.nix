{ fetchurl, lib, buildPythonPackage, python }:

let
  pname = "clustershell";
  version = "1.7.1";
in buildPythonPackage {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://pypi/c/${pname}/${pname}-${version}.tar.gz";
    sha256 = "1d15430d74d88283120b53562d063b3698044c11162f69b0c52ffa0d2d849d9f";
  };

  meta = {
    description = "Encoding and decoding yEnc";
    license = lib.licenses.lgpl21;
    homepage = https://bitbucket.org/dual75/yenc;
    maintainers = with lib.maintainers; [ fridh ];
  };
}
