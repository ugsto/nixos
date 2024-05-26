{ config, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    exec-once = [
      "mako"

      "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\""

      "[workspace 7 silent] flatpak run org.mozilla.Thunderbird"
      "[workspace 8 silent] flatpak run org.ferdium.Ferdium"
      "[workspace 9 silent] flatpak run com.github.KRTirtho.Spotube"

      "swaybg --mode fit --image ~/Imagens/wallpaper/current.jpg"
      "hypridle"
    ];
    exec = "~/.cargo/bin/eww open bar";

    bind = [
      "$mod Shift, Return, exec, $terminal"
      "$mod, R, exec, $menu"
      "$mod, L, exec, swaylock"

      ", Print, exec, grim - | wl-copy"
      "Shift, Print, exec, grim -g \"$(slurp)\" - | wl-copy"
      "Control, Print, exec, grim ~/Imagens/screenshots/$(date +%Y%m%d-%H%M%S).png"
      "Control Shift, Print, exec, grim -g \"$(slurp)\" ~/Imagens/screenshots/$(date +%Y%m%d-%H%M%S).png"

      "$mod, Q, killactive, "

      "$mod, V, togglefloating, "
      "$mod, P, pseudo,"
      "$mod, J, togglesplit,"
      "$mod, F, fullscreen,"

      "$mod, left, movefocus, h"
      "$mod, down, movefocus, j"
      "$mod, up, movefocus, k"
      "$mod, right, movefocus, l"

      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    decoration = {
      rounding = 16;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };

      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
    };

    env = [
      "XCURSOR_SIZE,24"
      "QT_QPA_PLATFORMTHEME,qt5ct"
    ];

    general = {
      gaps_in = 4;
      gaps_out = "16, 16, 4, 16";
      border_size = 2;


      layout = "dwindle";

      allow_tearing = false;
    };

    gestures = {
      workspace_swipe = "off";
    };

    input = {
      kb_layout = "br";
      kb_model = "abnt";

      follow_mouse = 1;

      touchpad = {
        natural_scroll = true;
      };

      sensitivity = 0;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_is_master = true;
    };

    misc = {
      disable_hyprland_logo = true;
      force_default_wallpaper = true;
    };

    monitor = [
      "HDMI-A-1, 1366x768@60, auto, auto"
      "eDP-1, 1920x1080@165, 1920x0, 1"
    ];

    windowrulev2 = "suppressevent maximize, class:.*";

    workspace = "m[1],gapsout:16";
  };
}
