{ stdenv, fetchFromGitHub, pkgconfig, ncurses, readline, conf ? null }:

with stdenv.lib;

stdenv.mkDerivation rec {
  pname = "nnn";
  version = "3.4";

  src = fetchFromGitHub {
    owner = "jarun";
    repo = pname;
    rev = "v${version}";
    sha256 = "0lyrpyhzzs2bdgx3ifq1c5dq3s2v30xdiaq0j8zjc64s6bghfxnd";
  };

  configFile = optionalString (conf != null) (builtins.toFile "nnn.h" conf);
  preBuild = optionalString (conf != null) "cp ${configFile} src/nnn.h";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ readline ncurses ];

  makeFlags = [ "DESTDIR=${placeholder "out"}" "PREFIX=" ];

  # shell completions and default plugins
  postInstall = ''
    install -Dm555 misc/auto-completion/bash/nnn-completion.bash $out/share/bash-completion/completions/nnn.bash
    install -Dm555 misc/auto-completion/zsh/_nnn -t $out/share/zsh/site-functions
    install -Dm555 misc/auto-completion/fish/nnn.fish -t $out/share/fish/vendor_completions.d
    install -Dm555 misc/quitcd/quitcd.bash_zsh $out/share/nnn/quitcd/quitcd.bash_zsh
    install -Dm555 misc/quitcd/quitcd.csh $out/share/nnn/quitcd/quitcd.csh
    install -Dm555 misc/quitcd/quitcd.fish $out/share/nnn/quitcd/quitcd.fish

    install -Dm555 plugins/* -t $out/share/nnn/plugins
    install -Dm555 plugins/.[a-zA-Z-09]* -t $out/share/nnn/plugins

    rm $out/share/nnn/plugins/README.md
  '';

  meta = {
    description = "Small ncurses-based file browser forked from noice";
    homepage = "https://github.com/jarun/nnn";
    license = licenses.bsd2;
    platforms = platforms.all;
    maintainers = with maintainers; [ jfrankenau filalex77 ];
  };
}
