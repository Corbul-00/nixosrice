{ lib, stdenvNoCC, unzip }:

stdenvNoCC.mkDerivation {
  pname = "frieren-cursors";
  version = "1.0";

  # 1. Em vez de URL, apontamos para o arquivo zip local (na mesma pasta)
  src = ./FrierenBLZ.zip;

  # 2. Adicionamos o unzip para que o Nix consiga extrair o arquivo
  nativeBuildInputs = [ unzip ];

  # O Nix já é inteligente: vendo o unzip ali em cima e um src terminando em .zip,
  # ele faz a extração automaticamente. Não precisamos de dontBuild ou fetchzip.

  installPhase = ''
    runHook preInstall

    # Cria a pasta do tema (precisa bater com o que tá no home.nix)
    mkdir -p $out/share/icons/Frieren
    
    # Copia tudo que foi extraído para dentro da pasta do cursor
    cp -r * $out/share/icons/Frieren/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Frieren Cursors";
    homepage = "https://www.gnome-look.org/";
    platforms = platforms.all;
  };
}
