with import (builtins.fetchGit {
  name = "nixos-19.09-2019-10-10";
  url = "https://github.com/NixOS/nixpkgs-channels";
  ref = "nixos-19.09";
  # Commit hash for nixos-19.09 as of 2019-10-10
  # `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-19.09`
  rev = "9bbad4c6254513fa62684da57886c4f988a92092";
}) {
  overlays = [(self: super:
    {
      python3 = super.python3.override {
        packageOverrides = py-self: py-super: {
          python-language-server = py-super.python-language-server.override {
            providers = [
              "rope"
              "pyflakes"
              "mccabe"
              "pycodestyle"
              "pydocstyle"
            ];
          };
        };
      };
    }
  )];
};

let src = fetchFromGitHub {
  owner = "mozilla";
  repo = "nixpkgs-mozilla";
  # Commit hash for master as of 2019-10-10
  # `git ls-remote https://github.com/mozilla/nixpkgs-mozilla master`
  rev = "d46240e8755d91bc36c0c38621af72bf5c489e13";
  sha256 = "0icws1cbdscic8s8lx292chvh3fkkbjp571j89lmmha7vl2n71jg";
};
in
with import "${src.out}/rust-overlay.nix" pkgs pkgs;
mkShell {
  name = "rustafarian";
  nativeBuildInputs = [
    # Note: to use stable, just replace `nightly` with `stable`
    #latest.rustChannels.nightly.rust
   ((rustChannelOf
     {
       date = "2019-08-01";
       channel = "nightly";
     }).rust.override {
       extensions = [
         "rls-preview"
         "rust-analysis"
         "rustfmt-preview"
       ];
     })

    # Build-time Additional Dependencies
    #pkgconfig
  ];

  # Run-time Additional Dependencies
  buildInputs = [
    pipenv

    python3

    # System libraries needed for Python packages
    #freetype # Demanded by matplotlib

    # Development tools
    lldb
    python3.pkgs.black
    python3.pkgs.epc
    python3.pkgs.importmagic
    python3.pkgs.isort
    python3.pkgs.jedi
    python3.pkgs.mypy
    python3.pkgs.pyls-black
    python3.pkgs.pyls-isort
    python3.pkgs.pyls-mypy
    python3.pkgs.python-language-server
    travis
  ];

  # Set Environment Variables
  RUST_BACKTRACE = 1;
  shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s) # required for python wheels

    # FIXME This is temporarily needed to avoid problems with Cargo
    unset SSL_CERT_FILE

    local venv=$(pipenv --bare --venv &>> /dev/null)

    if [[ -z $venv || ! -d $venv ]]; then
      pipenv install --dev &>> /dev/null
    fi

    export VIRTUAL_ENV=$(pipenv --venv)
    export PIPENV_ACTIVE=1
    export PYTHONPATH="$VIRTUAL_ENV/${python3.sitePackages}:$PYTHONPATH"
    export PATH="$VIRTUAL_ENV/bin:$PATH"
  '';
}
