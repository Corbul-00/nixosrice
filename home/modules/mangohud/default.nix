{ config, pkgs, ... }:

{
  programs.mangohud = {
    enable = true;
    # Habilita o MangoHUD para aplicações de 32 bits também
    enableSessionWide = true; 
    
    settings = {
      # Performance e Hardware
      cpu_stats = true;
      cpu_temp = true;
      gpu_stats = true;
      gpu_temp = true;
      ram = true;
      vram = true;
      fps = true;
      frame_timing = true;

      # Estética e Layout
      legacy_layout = false;
      horizontal = false; # Mude para true se quiser uma barra horizontal no topo
      table_columns = 3;
      font_size = 24;
      background_alpha = 0.5;
      round_corners = 10;
      
      # Posição (top-left, top-right, bottom-left, bottom-right)
      position = "top-left";

      # Atalhos
      toggle_hud = "Shift_R+F12";
      toggle_logging = "Shift_L+F2";

      # Evita abrir com
      no_display = "mpv";
    };
  };
}
