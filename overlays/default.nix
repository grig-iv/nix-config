self: super: {
  fennel-ls = super.callPackage ./fennel-ls.nix {};
  glsl_analyzer = super.callPackage ./glsl_analyzer.nix {};
}
