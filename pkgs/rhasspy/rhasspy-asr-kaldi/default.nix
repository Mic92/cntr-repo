{ lib
, buildPythonPackage
, fetchPypi
, networkx
, rhasspy-asr
, rhasspy-nlu
, pythonOlder
, fetchpatch
}:

buildPythonPackage rec {
  pname = "rhasspy-asr-kaldi";
  version = "0.5.0";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-aXUrVD5FF7kwAg6JYXgYv1ntDuC3gfKjGPxJj44BiIs=";
  };

  propagatedBuildInputs = [
    networkx
    rhasspy-asr
    rhasspy-nlu
  ];

  postPatch = ''
    sed -i "s/networkx==.*/networkx/" requirements.txt
  '';

  # misses files
  doCheck = false;

  meta = with lib; {
    description = "Speech to text library for Rhasspy using Kaldi";
    homepage = "https://github.com/rhasspy/rhasspy-asr-kaldi";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
