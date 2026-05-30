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
            # col tools
            aerospace
            bat
            brotli
            cowsay
            dav1d
            fastfetch
            fd
            ffmpeg
            fzf
            ghidra
            giflib
            gmp
            lolcat
            lsd
            neovim
            nmap
            qemu
            ripgrep
            starship
            stow
            tealdeer
            tmux
            yazi
            zinit
            zoxide

            # Language stuff
            go
            gopls
            jdt-language-server
            lua-language-server
            lua5_5
            luajit
            nixfmt
            pcre2
            python3
            quarkus
            rustup
            tailwindcss-language-server
            uv

            # Programming Tools
            awscli2
            clang
            clang-tools
            cmake
            docker-language-server
            gcc
            gh
            ninja
            nodejs_24
            postgresql
            premake
            redis
            terraform
            terraform-lsp

            # Linux Libraries and tools
            bash
            btop
            curl
            dtc
            fmt
            fontconfig
            freetype
            gdb
            gettext
            git
            glib
            gnutls
            gpp
            graphite2
            harfbuzz
            hdrhistogram_c
            htop
            libxext
            libxrender
            libzip
            lz4
            lzo
            mpfr
            ncurses
            nettle
            nmap
            oniguruma
            openssl
            p11-kit
            pixman
            pkgconf
          ];

          environment.variables = {
            LIBRARY_PATH = "${pkgs.libiconv}/lib";
          };

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
