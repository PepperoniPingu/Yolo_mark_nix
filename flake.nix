{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
	inherit system;
      };
      in {
	packages.default = 
	  pkgs.stdenv.mkDerivation {
	    src = ./.;
	    name = "yolo-mark";
	    nativeBuildInputs = [
	      pkgs.cmake
	      pkgs.gcc
	    ];
	    buildInputs = [
	      pkgs.opencv
	    ];
	    configurePhase = ''
	      cmake .
	    '';
	    buildPhase = ''
	      make
	    '';
	    installPhase = ''
	      mkdir -p $out/bin
	      mv yolo_mark $out/bin
	    '';
	  };
      });
}

