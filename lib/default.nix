{lib}:
lib.makeExtensible (self: {
  listFilesRecursive = dir:
    lib.flatten (lib.mapAttrsToList (
      name: type:
        if type == "directory"
        then lib.filesystem.listFilesRecursive (dir + "/${name}")
        else dir + "/${name}"
    ) (builtins.readDir dir));
})
