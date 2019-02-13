let
  hostPkgs = import <nixpkgs> {};
  nixpkgs = (hostPkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    # SHA for latest commit on 2019-02-11 for the nixos-unstable branch
    rev = "36f316007494c388df1fec434c1e658542e3c3cc";
    sha256 = "1w1dg9ankgi59r2mh0jilccz5c4gv30a6q1k6kv2sn8vfjazwp9k";
  });
in
  with import nixpkgs {
    overlays = [(self: super:
      {
      }
    )];
  };

  stdenv.mkDerivation {
    name = "rust-env";
    buildInputs = [
      rustup

      pipenv
      python3Packages.numpy
      python3Packages.pytest
      python3Packages.sphinx
      python3Packages.yapf

      # Example Additional Dependencies
      pkgconfig openssl
    ];

    # Set Environment Variables
    RUST_BACKTRACE = 1;
    src = null;
    shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)
    '';
  }
