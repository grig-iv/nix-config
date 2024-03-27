{lib, ...}:
with lib; {
  options.my = {
    windows = {
      user = mkOption {
        type = types.str;
      };
    };
  };
}
