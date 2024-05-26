{
  stdenv,
  lib,
  python3,
  makeWrapper,
  sources,
  plugins ? [],
  ...
}: let
  pluginDependencies = lib.unique (
    lib.flatten (
      builtins.map (p:
        if p ? pythonDependencies
        then p.pythonDependencies
        else [])
      plugins
    )
  );
in
  stdenv.mkDerivation rec {
    inherit (sources.danger-klipper) pname version src;

    sourceRoot = "source/klippy";

    # NB: This is needed for the postBuild step
    nativeBuildInputs = [
      (python3.withPackages (p: with p; [cffi]))
      makeWrapper
    ];

    buildInputs = [(python3.withPackages (p: with p; [can cffi pyserial greenlet jinja2 markupsafe numpy setuptools] ++ pluginDependencies))];

    # we need to run this to prebuild the chelper.
    postBuild = ''
      python ./chelper/__init__.py
    '';

    # Python 3 is already supported but shebangs aren't updated yet
    postPatch = ''
      for file in klippy.py console.py parsedump.py; do
        substituteInPlace $file \
          --replace '/usr/bin/env python2' '/usr/bin/env python'
      done
    '';

    # NB: We don't move the main entry point into `/bin`, or even symlink it,
    # because it uses relative paths to find necessary modules. We could wrap but
    # this is used 99% of the time as a service, so it's not worth the effort.
    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib/klippy
      cp -r ./* $out/lib/klippy

      # Moonraker expects `config_examples` and `docs` to be available
      # under `klipper_path`
      cp -r $src/docs $out/lib/docs
      cp -r $src/config $out/lib/config

      mkdir -p $out/bin
      chmod 755 $out/lib/klippy/klippy.py
      makeWrapper $out/lib/klippy/klippy.py $out/bin/klippy --chdir $out/lib/klippy

      # Symlink plugins
      ${
        lib.concatStringsSep "\n" (
          builtins.map
          # Filter only plugins with extras. There was a lib function for getting output in lib/attrset.nix
          (plugin: "ln -sf ${plugin}/lib/extras/*.py $out/lib/klippy/extras/")
          (builtins.filter (p: p ? klipper && p.klipper.extras) plugins)
        )
      }

      runHook postInstall
    '';

    passthru.plugins = plugins;

    meta = with lib; {
      description = "The Klipper 3D printer firmware";
      homepage = "https://github.com/KevinOConnor/klipper";
      platforms = platforms.linux;
      license = licenses.gpl3Only;
    };
  }
