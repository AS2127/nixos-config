{
	description = "A GUI for the Clipse clipboard";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
		clipse-gui = {
			url = "github:d7omdev/clipse-gui";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, flake-utils, clipse-gui }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs { inherit system; };
			in {
				packages.default = pkgs.stdenv.mkDerivation {
					pname = "clipse-gui";
					version = "git";

					src = clipse-gui;

					nativeBuildInputs = with pkgs; [
						wrapGAppsHook
						makeWrapper
					];

					buildInputs = with pkgs; [
						gtk3
						gobject-introspection
						glib
						wl-clipboard
						wtype
						python313
						python313Packages.pygobject3
					];

					installPhase = ''
						runHook preInstall
						mkdir -p $out/lib/clipse-gui
						cp -r * $out/lib/clipse-gui/

						mkdir -p $out/bin
						makeWrapper ${pkgs.python313.interpreter} $out/bin/clipse-gui \
							--set PYTHONPATH $PYTHONPATH \
							--add-flags "$out/lib/clipse-gui/clipse-gui.py"
						runHook postInstall
					'';

					meta = with pkgs.lib; {
						description = "A GUI for the Clipse clipboard";
						homepage = "https://github.com/d7omdev/clipse-gui";
						license = licenses.gpl3Only;
						platforms = platforms.linux;
					};
				};
			});
}

