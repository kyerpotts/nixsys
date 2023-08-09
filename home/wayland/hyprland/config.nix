{ config, default, ... }:
let
  inherit (default) colors;

  pointer = config.home.pointerCursor;
  homeDir = config.home.homeDirectory;
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";
      exec-once = [
      "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "wlsunset -t 5200 -S 9:00 -s 19:30"
      "waybar"
      "dunst"
      "xwaylandvideobridge"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
      "echo 'Xft.dpi: 130 | xrdb -merge"
      ];
      xwayland = { force_zero_scaling = true; };
      input = {
        kb_layout = us;
        # focus change on cursor move
        follow_mouse = 1;
        accel_profile = flat;
        touchpad = {
          scroll_factor = 0.3;
        };
      };
      misc = {
        disable_autoreload = false
        animate_mouse_windowdragging = true;
        vrr = 0;
        vfr = true;
        disable_splash_rendering = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" =
        "rgb(${colors.base}) rgb(${colors.mantle}) 270deg";
        "col.inactive_border" =
        "rgb(${colors.crust}) rgb(${colors.mantle}) 270deg";
        # group borders
        "col.group_border_active" = "rgb(${colors.pink})";
        "col.group_border" = "rgb(${colors.surface0})";
        "no_border_on_floating" = false
        layout = "dwindle";
      };
      decoration = {
        rounding = 5;
        multisample_edges = true;
        blur = {
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          noise = "0.0117";
          contrast = "1.1";
          brightness = "1.2";
          xray = true;
        };
        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "0 8";
        shadow_range = 50;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000099)";
        blurls = [ "gtk-layer-shell" "waybar" "lockscreen" ];
      };
      animation = {
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };
      dwindle = {
        no_gaps_when_only = false
        pseudotile = true;
        preserve_split = true;
      };
      master = { new_is_master = true; };

      "$VIDEODIR" = "$HOME/Videos";
      "$NOTIFY" = "notify-send -h string:x-canonical-private-synchonouse:hypr-cfg -u low";
      "$SCREENSHOT" = "mkdir -p ~/Screenshots; grim -t png -g "$(slurp)" ~/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).png";

      bind = [
        "$MOD, Escape, exec, wlogout -p layer-shell"
        "$MOD, V, exec, wf-recorder -f $VIDEODIR/$(date +%Y-%m-%d_%H-%M-%S).mp4"
        "$MOD, V, exec, $NOTIFY 'Recording started'"
        "$MODSHIFT, V, exec, killall -s SIGINT wf-recorder"
        "$MODSHIFT, V, exec, $NOTIFY 'Recording stopped'"
        "$MODSHIFT, P, exec, $SCREENSHOT"

        "$MOD, D, exec, pkill .${default.launcher}-wrapped || run-as-service ${default.launcher}"
        "$MOD, Return, exec, run-as-service ${default.terminal.name}"
        "$MOD, W, exec, firefox"
        "$MOD, E, exec, run-as-service ${default.terminal.name} -e lf"


        "$MODSHIFT, L, exec, loginctl lock-session"
        "$MOD, Q, killactive"
        "$MODSHIFT, Q, exit"
        "$MOD, F, fullscreen"
        "$MOD, S, togglesplit"
        "$MOD, T, togglefloating"
        "$MOD, P, pseudo"
        "$MOD, Tab, cyclenext"
        "$MOD, Tab, bringactivetotop"

        "$MODSHIFT, O, workspaceopt, allfloat"
        "$MODSHIFT, O, exec, $NOTIFY 'Toggled floating windows'"
        "$MODSHIFT, P, workspaceopt, allpseudotile"
        "$MODSHIFT, P, exec, $NOTIFY 'Toggled pseudotile windows'"

        "$MOD, A, togglespecialworkspace"
        "$MOD, A, exec, $NOTIFY 'Toggled special workspace'"
        "$MODSHIFT, A, movetoworkspace, special"
        "$MOD, C, exec, hyprctl dispatch centerwindow"

        # Move workspaces
        "${builtins.concatStringsSep "\n" (builtins.genList (x:
          let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
            bind = $MODSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
          '') 10)}"

        "$MOD, mouse_down, workspace, e-1"
        "$MOD, mouse_up, workspace, e+1"

        # Move focus
        "$MOD, H, movefocus, l"
        "$MOD, L, movefocus, r"
        "$MOD, J, movefocus, u"
        "$MOD, K, movefocus, d"

        # Resize window
        #TODO: this might not work
        "$MOD, Z, submap, resize"
        "submap = resize"
        "binde = , right, resizeactive, 10 0"
        "binde = , left, resizeactive, -10 0"
        "binde = , up, resizeactive, 0 -10"
        "binde = , down, resizeactive, 0 10"
        "binde = , escape, submap, reset"
        "submap = reset"
      ];
      bindm = [ "$MOD, mouse:272, movewindow" "$MOD, mouse:273, resizewindow"];

      # Media Controls
      bindl = [
        " , XF86AudioPlay, exec, playerctl play-pause"
        " , XF86AudioPrev, exec, playerctl previous"
        " , XF86AudioNext, exec, playerctl next"
        " , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        " , XF86AudioMicMute, exec, wpctl set-mute @SOURCE@ toggle"
      ];
      bindle = [
        " , XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+"
        " , XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-"

        # backlight
        " , XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
        " , XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
      ];
      windowrulev2 = [
        "opacity 0.90 0.90,class:^(org.wezfurlong.wezterm)$"
        "opacity 0.90 0.90,class:^(firefox)$"
        # may need to change this for spotify-tui
        "opacity 0.80 0.80,class:^(Spotify)$"
        "opacity 0.80 0.80,class:^(thunar)$"
        "opacity 0.80 0.80,class:^(file-roller)$"
        "opacity 0.80 0.80,class:^(nwg-look)$"
        "opacity 0.80 0.80,class:^(qt5ct)$"
        "opacity 0.80 0.80,class:^(discord)$"
        "opacity 0.80 0.80,class:^(WebCord)$"
        "opacity 0.80 0.70,class:^(pavucontrol)$"
        "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "opacity 0.80 0.80,class:^(code-url-handler)$"
        "opacity 0.80 0.80,title:^(Spotify)$"

        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float,class:^(pavucontrol)$"
        "float,title:^(Media viewer)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Picture-in-Picture)$"
        "float,class:^(Viewnior)$"
        "float,title:^(DevTools)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"

        "noshadow, floating:0"

        # This line may be redundant if using spotify-tui
        "title, title:^(Spotify)$"

        "idleinhibit focus, class:^(mpv|.+exe)$"
        "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(firefox)$"

        "rounding 0, xwayland:1, floating:1"
        # this could be useful if I ever use jetbrains
        # "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
        # "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"

        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
      ];
      layerrule = [
        "blur, ^(gtk-layer-shell|anyrun)$"
        "ignorezero, ^(gtk-layer-shell|anyrun)$"
      ];
    };
  };
}
