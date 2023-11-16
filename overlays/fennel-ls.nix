{
  stdenv,
  makeWrapper,
  lua,
  ...
}:
stdenv.mkDerivation {
  pname = "fennel-ls";
  version = "82452557";
  buildInputs = [lua makeWrapper];

  installFlags = ["PREFIX=${placeholder "out"}"];

  src = builtins.fetchGit {
    url = "https://git.sr.ht/~xerool/fennel-ls";
    ref = "main";
    rev = "824525573a6299c232a0b910a960bd59a563904f";
  };
}
