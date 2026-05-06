{ config, pkgs, ... }:

{
  # === FONTES (coloque aqui ou em um módulo fonts.nix separado) ===
  fonts.fontconfig.enable = true;   # essencial para Home-Manager gerenciar fontes

  home.packages = with pkgs; [
    # Fonte principal com Nerd Font patches (recomendado para 25.11+)
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    # Opcional: se quiser mais símbolos extras
    # nerd-fonts.symbols-only
    # font-awesome   # caso precise de fallback antigo
  ];


  # home.packages para playerctl continua aqui se quiser
}
