{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      rust-bin.stable.latest.minimal
      rust-bin.stable.latest.clippy

      rust-bin.nightly.latest.rustfmt
      rust-bin.nightly.latest.rust-analyzer

      evcxr
      openssl

      gcc
    ];

    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };
}
