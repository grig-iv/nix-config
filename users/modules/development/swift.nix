{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    swift
    swiftPackages.swiftpm # packet manager
    sourcekit-lsp # lsp

    # deps
    # clang
  ];

  #home.sessionVariables."LD_LIBRARY_PATH" = "${pkgs.swift-corelibs-libdispatch}/lib:";

  home.activation.setLD_LIBRARY_PATH = config.lib.dag.entryAfter ["writeBoundary"] ''
    export LD_LIBRARY_PATH=${pkgs.swift-corelibs-libdispatch}/lib:$LD_LIBRARY_PATH
  '';
}
