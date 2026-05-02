{ lib, buildGoModule, fetchFromGitHub, makeWrapper, tmux, git, gh, vhs, python3 }:

buildGoModule rec {
  pname = "tuiwall";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Mug-Costanza";
    repo = "tuiwall";
    rev = "v${version}";
    hash = "sha256-npPlo88saCiA6D3LrjJ8qQesmO3lI+LWEEagkbIavFU=";
  };

  vendorHash = "sha256-JjXY4EargMoCMtmcUHyQwFRnMMyBUoZTm0ROgnwJ8wg=";

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/tuiwall \
      --prefix PATH : ${lib.makeBinPath [ tmux git gh vhs python3 ]}
  '';

  meta = with lib; {
    description = "CLI wallpaper engine for the terminal";
    homepage = "https://github.com/Mug-Costanza/tuiwall";
    license = licenses.mit;
    mainProgram = "tuiwall";
  };
}
