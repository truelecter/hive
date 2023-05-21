{
  inputs,
  cell,
}: {
  common-packages = _: _: cell.packages;
  latest-overrides = _: _: cell.overrides;
}
