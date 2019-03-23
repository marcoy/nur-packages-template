{ stdenv, fetchFromGitHub, gitstatus }:

stdenv.mkDerivation {
  name = "powerlevel10k";

  src = fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "1140a79b109fc7230276241f1869b1e742e7041d";
    sha256 = "1fq6hqqknbr9asp2ib66nyha1yj0pv2pdvr7165bymfym99p0spp";
  };

  installPhase = ''
    GITSTATUS="${gitstatus}/bin/gitstatusd"
    substituteInPlace gitstatus/gitstatus.plugin.zsh \
      --replace 'daemon=''${GITSTATUS_DAEMON:-''${''${(%):-%x}:A:h}/bin/gitstatusd-''${os:l}-''${arch:l}}' "daemon=$GITSTATUS"
    install -D functions/* -t $out/share/powerlevel10k/functions
    install -D powerlevel9k.zsh-theme -t $out/share/powerlevel10k
    install -D gitstatus/gitstatus.plugin.zsh -t $out/share/powerlevel10k/gitstatus

    pushd $out/share/powerlevel10k
    ln -s powerlevel9k.zsh-theme \
          powerlevel10k.zsh-theme
    ln -s powerlevel9k.zsh-theme \
          prompt_powerlevel9k_setup 
    ln -s prompt_powerlevel9k_setup \
          prompt_powerlevel10k_setup
    popd
  '';
}
