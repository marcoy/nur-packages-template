{ stdenv, fetchFromGitHub, gitstatus }:

stdenv.mkDerivation {
  name = "powerlevel10k";

  src = fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "0710cc7221cef20b73eeb75c6b3f2043ff56d019";
    sha256 = "0cks6ddb1s6xdmklbcr7wplkl4dl2cj5mlf2vl24kakcpva2wvbb";
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
