{
  inputs,
  cell,
}: {
  home.packages = [
    inputs.cells.common.overrides.android-tools
  ];
}
