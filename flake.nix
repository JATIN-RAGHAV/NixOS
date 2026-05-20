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
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            cargo
            clippy
            rustfmt
            rustc
            rustup
            rust-analyzer
            uv
            redis
            tailwindcss-language-server
            jdt-language-server
            quarkus
            pass
            htop
            fd
            stow
            zinit
            zoxide
            starship
            aerospace
            terraform-lsp
            awscli2
            python3
            qemu
            terraform
            bash
            postgresql
            brotli
            btop
            cairo
            capstone
            clang
            clang-tools
            cmake
            cowsay
            curl
            dav1d
            docker-language-server
            dtc
            ffmpeg
            fmt
            fontconfig
            freetype
            gcc
            gettext
            gh
            ghidra
            giflib
            git
            glib
            gmp
            gnutls
            go
            gopls
            gpp
            graphite2
            harfbuzz
            hdrhistogram_c
            libxext
            libxrender
            libzip
            llhttp
            lolcat
            lsd
            lua
            lua-language-server
            luajit
            lz4
            lzo
            mpdecimal
            mpfr
            ncurses
            nettle
            neovim
            ninja
            nixfmt
            nmap
            nodejs_24
            oniguruma
            openssl
            p11-kit
            pcre2
            pixman
            pkgconf
            premake
            ripgrep
            tmux
            tealdeer
          ];

          nix.settings.experimental-features = "nix-command flakes";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          nixpkgs.config.allowUnfree = true;
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
