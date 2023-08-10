{
  inputs,
  cell,
}:
cell.lib.importProfiles {
  src = ./profiles;

  inputs = {
    inherit cell inputs;
  };
}
