{
  pkgs = hackage:
    {
      packages = {
        "pretty".revision = (((hackage."pretty")."1.1.3.6").revisions).default;
        "text".revision = (((hackage."text")."1.2.5.0").revisions).default;
        "array".revision = (((hackage."array")."0.5.4.0").revisions).default;
        "extra".revision = (((hackage."extra")."1.7.10").revisions).default;
        "shelly".revision = (((hackage."shelly")."1.10.0").revisions).default;
        "shelly".flags.build-examples = false;
        "shelly".flags.lifted = false;
        "mtl".revision = (((hackage."mtl")."2.2.2").revisions).default;
        "bytestring".revision = (((hackage."bytestring")."0.10.12.1").revisions).default;
        "filepath".revision = (((hackage."filepath")."1.4.2.1").revisions).default;
        "terminal-size".revision = (((hackage."terminal-size")."0.3.3").revisions).default;
        "stm".revision = (((hackage."stm")."2.5.0.0").revisions).default;
        "unix-compat".revision = (((hackage."unix-compat")."0.6").revisions).default;
        "unix-compat".flags.old-time = false;
        "type-equality".revision = (((hackage."type-equality")."1").revisions).default;
        "hinotify".revision = (((hackage."hinotify")."0.4.1").revisions).default;
        "ghc-prim".revision = (((hackage."ghc-prim")."0.7.0").revisions).default;
        "ghc-boot-th".revision = (((hackage."ghc-boot-th")."9.0.2").revisions).default;
        "lifted-async".revision = (((hackage."lifted-async")."0.10.2.2").revisions).default;
        "base".revision = (((hackage."base")."4.15.1.0").revisions).default;
        "time".revision = (((hackage."time")."1.9.3").revisions).default;
        "async".revision = (((hackage."async")."2.2.4").revisions).default;
        "async".flags.bench = false;
        "process".revision = (((hackage."process")."1.6.13.2").revisions).default;
        "fsnotify".revision = (((hackage."fsnotify")."0.3.0.1").revisions).default;
        "transformers-base".revision = (((hackage."transformers-base")."0.4.6").revisions).default;
        "transformers-base".flags.orphaninstances = true;
        "hsc2hs".revision = (((hackage."hsc2hs")."0.68.8").revisions).default;
        "hsc2hs".flags.in-ghc-tree = false;
        "base-orphans".revision = (((hackage."base-orphans")."0.8.6").revisions).default;
        "ghc-bignum".revision = (((hackage."ghc-bignum")."1.1").revisions).default;
        "directory".revision = (((hackage."directory")."1.3.6.2").revisions).default;
        "exceptions".revision = (((hackage."exceptions")."0.10.4").revisions).default;
        "constraints".revision = (((hackage."constraints")."0.13.4").revisions).default;
        "lifted-base".revision = (((hackage."lifted-base")."0.2.3.12").revisions).default;
        "clock".revision = (((hackage."clock")."0.8.3").revisions).default;
        "clock".flags.llvm = false;
        "rts".revision = (((hackage."rts")."1.0.2").revisions).default;
        "monad-control".revision = (((hackage."monad-control")."1.0.3.1").revisions).default;
        "transformers".revision = (((hackage."transformers")."0.5.6.2").revisions).default;
        "template-haskell".revision = (((hackage."template-haskell")."2.17.0.0").revisions).default;
        "enclosed-exceptions".revision = (((hackage."enclosed-exceptions")."1.0.3").revisions).default;
        "deepseq".revision = (((hackage."deepseq")."1.4.5.0").revisions).default;
        "unix".revision = (((hackage."unix")."2.7.2.2").revisions).default;
        "ansi-terminal".revision = (((hackage."ansi-terminal")."0.11.3").revisions).default;
        "ansi-terminal".flags.example = false;
        "hashable".revision = (((hackage."hashable")."1.4.0.2").revisions).default;
        "hashable".flags.containers = true;
        "hashable".flags.random-initial-seed = false;
        "hashable".flags.integer-gmp = true;
        "cmdargs".revision = (((hackage."cmdargs")."0.10.21").revisions).default;
        "cmdargs".flags.quotation = true;
        "cmdargs".flags.testprog = false;
        "transformers-compat".revision = (((hackage."transformers-compat")."0.7.2").revisions).default;
        "transformers-compat".flags.two = false;
        "transformers-compat".flags.mtl = true;
        "transformers-compat".flags.four = false;
        "transformers-compat".flags.five = false;
        "transformers-compat".flags.five-three = true;
        "transformers-compat".flags.three = false;
        "transformers-compat".flags.generic-deriving = true;
        "binary".revision = (((hackage."binary")."0.8.8.0").revisions).default;
        "containers".revision = (((hackage."containers")."0.6.4.1").revisions).default;
        "colour".revision = (((hackage."colour")."2.3.6").revisions).default;
        };
      compiler = {
        version = "9.0.2";
        nix-name = "ghc902";
        packages = {
          "pretty" = "1.1.3.6";
          "text" = "1.2.5.0";
          "array" = "0.5.4.0";
          "mtl" = "2.2.2";
          "bytestring" = "0.10.12.1";
          "filepath" = "1.4.2.1";
          "stm" = "2.5.0.0";
          "ghc-prim" = "0.7.0";
          "ghc-boot-th" = "9.0.2";
          "base" = "4.15.1.0";
          "time" = "1.9.3";
          "process" = "1.6.13.2";
          "ghc-bignum" = "1.1";
          "directory" = "1.3.6.2";
          "exceptions" = "0.10.4";
          "rts" = "1.0.2";
          "transformers" = "0.5.6.2";
          "template-haskell" = "2.17.0.0";
          "deepseq" = "1.4.5.0";
          "unix" = "2.7.2.2";
          "binary" = "0.8.8.0";
          "containers" = "0.6.4.1";
          };
        };
      };
  extras = hackage:
    { packages = { ghcid = ./.plan.nix/ghcid.nix; }; };
  modules = [
    ({ lib, ... }:
      { packages = { "ghcid" = { flags = {}; }; }; })
    ({ lib, ... }:
      {
        packages = {
          "ansi-terminal".components.library.planned = lib.mkOverride 900 true;
          "shelly".components.library.planned = lib.mkOverride 900 true;
          "terminal-size".components.library.planned = lib.mkOverride 900 true;
          "transformers-base".components.library.planned = lib.mkOverride 900 true;
          "base-orphans".components.library.planned = lib.mkOverride 900 true;
          "extra".components.library.planned = lib.mkOverride 900 true;
          "filepath".components.library.planned = lib.mkOverride 900 true;
          "pretty".components.library.planned = lib.mkOverride 900 true;
          "bytestring".components.library.planned = lib.mkOverride 900 true;
          "exceptions".components.library.planned = lib.mkOverride 900 true;
          "ghc-prim".components.library.planned = lib.mkOverride 900 true;
          "array".components.library.planned = lib.mkOverride 900 true;
          "binary".components.library.planned = lib.mkOverride 900 true;
          "ghc-boot-th".components.library.planned = lib.mkOverride 900 true;
          "rts".components.library.planned = lib.mkOverride 900 true;
          "unix".components.library.planned = lib.mkOverride 900 true;
          "hsc2hs".components.exes."hsc2hs".planned = lib.mkOverride 900 true;
          "type-equality".components.library.planned = lib.mkOverride 900 true;
          "ghcid".components.exes."ghcid".planned = lib.mkOverride 900 true;
          "directory".components.library.planned = lib.mkOverride 900 true;
          "time".components.library.planned = lib.mkOverride 900 true;
          "cmdargs".components.library.planned = lib.mkOverride 900 true;
          "unix-compat".components.library.planned = lib.mkOverride 900 true;
          "ghcid".components.library.planned = lib.mkOverride 900 true;
          "lifted-base".components.library.planned = lib.mkOverride 900 true;
          "ghc-bignum".components.library.planned = lib.mkOverride 900 true;
          "constraints".components.library.planned = lib.mkOverride 900 true;
          "fsnotify".components.library.planned = lib.mkOverride 900 true;
          "enclosed-exceptions".components.library.planned = lib.mkOverride 900 true;
          "process".components.library.planned = lib.mkOverride 900 true;
          "clock".components.library.planned = lib.mkOverride 900 true;
          "template-haskell".components.library.planned = lib.mkOverride 900 true;
          "stm".components.library.planned = lib.mkOverride 900 true;
          "async".components.library.planned = lib.mkOverride 900 true;
          "mtl".components.library.planned = lib.mkOverride 900 true;
          "transformers".components.library.planned = lib.mkOverride 900 true;
          "deepseq".components.library.planned = lib.mkOverride 900 true;
          "lifted-async".components.library.planned = lib.mkOverride 900 true;
          "text".components.library.planned = lib.mkOverride 900 true;
          "base".components.library.planned = lib.mkOverride 900 true;
          "transformers-compat".components.library.planned = lib.mkOverride 900 true;
          "monad-control".components.library.planned = lib.mkOverride 900 true;
          "colour".components.library.planned = lib.mkOverride 900 true;
          "containers".components.library.planned = lib.mkOverride 900 true;
          "hinotify".components.library.planned = lib.mkOverride 900 true;
          "hashable".components.library.planned = lib.mkOverride 900 true;
          };
        })
    ];
  }