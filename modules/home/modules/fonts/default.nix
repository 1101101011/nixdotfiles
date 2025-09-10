{ config, lib, pkgs, inputs, ... }:
let
  productSans = pkgs.stdenv.mkDerivation {
    name = "google-sans";
    src = pkgs.fetchFromGitHub {
      owner = "hprobotic";
      repo = "Google-Sans-Font";
      rev = "master";
      sha256 = "1q1cc1gh3kaphkxqig3f4wng538drx6xp43scfvy7vzn8s14mdzk";
    };
    installPhase = ''
      mkdir -p $out/share/fonts/product-sans
      cp -v $src/*.ttf $out/share/fonts/product-sans/
    '';
  };
  # manicDepressive = pkgs.stdenv.mkDerivation {
  #   name = "custom-font";
  #   src = ./fonts; 
  #   installPhase = ''
  #     mkdir -p $out/share/fonts/manic-depressive
  #     cp $src/manic-depressive.ttf $out/share/fonts/manic-depressive/
  #   '';
  # };
in
{
  home.packages = with pkgs; [
    productSans
    # manicDepressive
    fantasque-sans-mono
    jetbrains-mono
    source-han-sans
    font-awesome
    font-awesome_4
    font-awesome_5
    twemoji-color-font
    migu
    montserrat
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-han-code-jp
    nerd-fonts.code-new-roman
    nerd-fonts.comic-shanns-mono
    nerd-fonts.commit-mono
    nerd-fonts.cousine
    nerd-fonts.d2coding
    nerd-fonts.daddy-time-mono
    nerd-fonts.departure-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.envy-code-r
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.geist-mono
    nerd-fonts.go-mono
    nerd-fonts.gohufont
    nerd-fonts.hack
    nerd-fonts.hasklug
    nerd-fonts.heavy-data
    nerd-fonts.hurmit
    nerd-fonts.im-writing
    nerd-fonts.inconsolata
    nerd-fonts.inconsolata-go
    nerd-fonts.inconsolata-lgc
    nerd-fonts.intone-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.jetbrains-mono
    /* nerd-fonts.lekton
    nerd-fonts.liberation
    nerd-fonts.lilex
    nerd-fonts.martian-mono
    nerd-fonts.meslo-lg
    nerd-fonts.monaspace
    nerd-fonts.monofur
    nerd-fonts.monoid
    nerd-fonts.mononoki
    nerd-fonts.noto
    nerd-fonts.open-dyslexic
    nerd-fonts.overpass
    nerd-fonts.profont
    nerd-fonts.proggy-clean-tt
    nerd-fonts.recursive-mono
    nerd-fonts.roboto-mono
    nerd-fonts.shure-tech-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.space-mono
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    nerd-fonts.victor-mono */
    nerd-fonts.zed-mono
  ];
}
