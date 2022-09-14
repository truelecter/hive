final: prev: {
  octoprint = prev.octoprint.override {
    packageOverrides = pyself: pysuper: {
      octoprint-display-layer-progress = pyself.buildPythonPackage rec {
        inherit (prev.sources.octoprint-display-layer-progress) pname version src;

        propagatedBuildInputs = [pysuper.octoprint];
        doCheck = false;
      };

      eeprom-editor = pyself.buildPythonPackage rec {
        inherit (prev.sources.eeprom-editor) pname version src;

        propagatedBuildInputs = [pysuper.octoprint];
        doCheck = false;
      };
    };
  };
}
