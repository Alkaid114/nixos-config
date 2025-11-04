{pkgs,...}:
{
  home.packages = with pkgs; [
    # rust-analyzer
    # cargo
    cargo-edit
    cargo-watch
    rustup
    pkg-config
    openssl
    # rustc
    # clippy
    # rustfmt
    cargo-generate
  ];
}