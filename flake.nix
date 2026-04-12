{
    description = "walrusOS";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:nix-darwin/nix-darwin/master";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs =
        {
        self,
        nix-darwin,
        nixpkgs,
        }@inputs:
        let
            configuration =
                { pkgs, ... }:
                {
                    environment.systemPackages = [
                        pkgs.neovim
                        pkgs.btop
                        pkgs.lsd
                        pkgs.tmux
                        pkgs.lua
                        pkgs.libxext
                        pkgs.bash
                        pkgs.libxrender
                        pkgs.brotli
                        pkgs.libzip
                        pkgs.btop
                        pkgs.llhttp
                        pkgs.lolcat
                        pkgs.cairo
                        pkgs.capstone
                        pkgs.lsd
                        pkgs.cmake
                        pkgs.lua
                        pkgs.cowsay
                        pkgs.lua-language-server
                        pkgs.curl
                        pkgs.luajit
                        pkgs.dav1d
                        pkgs.docker-language-server
                        pkgs.lz4
                        pkgs.dtc
                        pkgs.lzo
                        pkgs.ffmpeg
                        pkgs.mpdecimal
                        pkgs.fmt
                        pkgs.mpfr
                        pkgs.fontconfig
                        pkgs.ncurses
                        pkgs.freetype
                        pkgs.neovim
                        pkgs.gcc
                        pkgs.nettle
                        pkgs.gettext
                        pkgs.ninja
                        pkgs.gh
                        pkgs.nixfmt
                        pkgs.ghidra
                        pkgs.nmap
                        pkgs.giflib
                        pkgs.nodejs_24
                        pkgs.git
                        pkgs.oniguruma
                        pkgs.glib
                        pkgs.gmp
                        pkgs.openssl
                        pkgs.gnutls
                        pkgs.go
                        pkgs.p11-kit
                        pkgs.gopls
                        pkgs.pcre2
                        pkgs.graphite2
                        pkgs.pixman
                        pkgs.harfbuzz
                        pkgs.pkgconf
                        pkgs.hdrhistogram_c
                        pkgs.premake
                    ];

                    nix.settings.experimental-features = "nix-command flakes";

                    # Enable alternative shell support in nix-darwin.
                    # programs.fish.enable = true;

                    # Set Git commit hash for darwin-version.
                    system.configurationRevision = self.rev or self.dirtyRev or null;

                    # Used for backwards compatibility, please read the changelog before changing.
                    # $ darwin-rebuild changelog
                    system.stateVersion = 6;

                    # The platform the configuration will be used on.
                    nixpkgs.hostPlatform = "aarch64-darwin";
                };
        in
            {
            # Build darwin flake using:
            # $ darwin-rebuild build --flake .#simple
            darwinConfigurations."walrus" = nix-darwin.lib.darwinSystem {
                modules = [ configuration ];
            };
        };
}
