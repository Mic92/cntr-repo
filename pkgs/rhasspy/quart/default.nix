{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, aiofiles
, blinker
, click
, hypercorn
, itsdangerous
, jinja2
, toml
, werkzeug
, pytest
, hypothesis
, pytest-asyncio
, asynctest
}:

buildPythonPackage rec {
  pname = "quart";
  version = "0.12.0";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    pname = "Quart";
    inherit version;
    sha256 = "99a65bc90d0e1260c9cc9a7dd0b8523eb6cd9f4ec146e771e98a55ee180ae6c2";
  };

  # # Package conditions to handle
  # # might have to sed setup.py and egg.info in patchPhase
  # # sed -i "s/<package>.../<package>/"
  # # Extra packages (may not be necessary)
  # python-dotenv ; extra == 'dotenv'
  propagatedBuildInputs = [
    aiofiles
    blinker
    click
    hypercorn
    itsdangerous
    jinja2
    toml
    werkzeug
  ];

  checkInputs = [
    pytest
    hypothesis
    pytest-asyncio
    asynctest
  ];

  meta = with lib; {
    description = "A Python ASGI web microframework with the same API as Flask";
    homepage = https://gitlab.com/pgjones/quart/;
    license = licenses.mit;
  };
}
