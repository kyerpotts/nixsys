{ config, pkgs, lib, osConfig, default, ... }:
{
  mainBar = {
    position = "top";
    layer = "top";
    height = 16;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "custom/playerctl#backward"
      "custom/playerctl#play"
      "custom/playerctl#forward"
      "custom/playerlabel"
      "cava#left"
    ];
    modules-center = [
      "wlr/workspaces"
      "hyprland/window"
    ];
    modules-right = [
      "tray"
      "battery"
      "pulseaudio"
      "bluetooth"
      "network"
      "clock"
    ];
    clock = {
      format = "󱑍 {:%H:%M}";
      tooltip = true;
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = " {:%d/%m}";
    };
    "wlr/workspaces" = {
      active-only = false;
      all-outputs = false;
      disable-scroll = false;
      on-scroll-up = "hyprctl dispatch workspace e-1";
      on-scroll-down = "hyprctl dispatch workspace e+1";
      format = "{name}";
      on-click = "activate";
      format-icons = {
        urgent = "";
        active = "";
        default = "";
        sort-by-number = true;
      };
    };
    "hyprland/window" = {
      format = "{title}";
      rewrite = [
       "(.*) - Mozilla Firefox": "$1"
       "(.*) - nvim": "$1"
       "(.*) - zsh": "[$1]"
      ];
    };
    "cava#left" = {
      framerate = 60;
      autosens = 1;
      sensitivity = 100;
      bars = 18;
      lower_cutoff_freq = 50;
      higher_cutoff_freq = 10000;
      method = "pipewire";
      source = "auto";
      stereo = true;
      reverse = false;
      bar_delimiter = 0;
      monstercat = false;
      waves = false;
      input_delay = 2;
      format-icons = [
        "<span foreground='#${custom.primary_accent}'>▁</span>"
        "<span foreground='#${custom.primary_accent}'>▂</span>"
        "<span foreground='#${custom.primary_accent}'>▃</span>"
        "<span foreground='#${custom.primary_accent}'>▄</span>"
        "<span foreground='#${custom.secondary_accent}'>▅</span>"
        "<span foreground='#${custom.secondary_accent}'>▆</span>"
        "<span foreground='#${custom.secondary_accent}'>▇</span>"
        "<span foreground='#${custom.secondary_accent}'>█</span>"
      ];
    };
    "custom/launcher" = {
      format = "";
      on-click = "pkill .${default.launcher}-wrapped || run-as-service ${default.launcher}";
      tooltip = "false";
    };
    "custom/playerctl#backward" = {
      format= "󰙣 ";
      on-click= "playerctl previous";
      on-scroll-up = "playerctl volume .5+";
      on-scroll-down = "playerctl volume .5-";
    };
    "custom/playerctl#play"= {
      format= "{icon}";
      return-type= "json";
      exec= "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click= "playerctl play-pause";
      on-scroll-up = "playerctl volume .05+";
      on-scroll-down = "playerctl volume .05-";
      format-icons= {
        Playing = "<span>󰏥 </span>";
        Paused = "<span> </span>";
        Stopped = "<span> </span>";
      };
    };
    "custom/playerctl#foward"= {
      format= "󰙡 ";
      on-click= "playerctl next";
      on-scroll-up = "playerctl volume .05+";
      on-scroll-down = "playerctl volume .05-";
    };
    "custom/playerlabel"= {
      format= "<span>󰎈 {} 󰎈</span>";
      return-type= "json";
      max-length= 40;
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click= "";
    };
    battery = {
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-charging = " {icon} {capacity}%";
      format-plugged = " {icon} {capacity}%";
      format-alt = "{icon} {time}";
      format-icons = [ "" "" "" "" "" ];
    };
    memory = {
      format = "󰍛 {}%";
      format-alt = "󰍛 {used}/{total} GiB";
      interval = 5;
    };
    cpu = {
      format = "󰻠 {usage}%";
      format-alt = "󰻠 {avg_frequency} GHz";
      interval = 5;
    };
    disk = {
      format = "󰋊 {}%";
      format-alt = "󰋊 {used}/{total} GiB";
      interval = 5;
      path = "/";
    };
    network = {
      format-wifi = "  {signalStrength}%";
      format-ethernet = "󰈀 100% ";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "󰖪 0% ";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    backlight = {
      device = "acpi_video1";
      format = "{icon} {percent}%";
      format-icons = [ "" "" "" "" "" "" "" "" "" ];
      on-scroll-up = "brillo -q -u 300000 -A 5";
      on-scroll-down = "brillo -q -u 300000 -U 5";
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} {volume}%";
      format-source = " {volume}%";
      format-muted = "󰝟";
      format-source-muted = " {volume}%";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        default = [ "󰕿" "󰖀" "󱄠" ];
      };
      scroll-step = 1;
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-scroll-up = "wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%+";
      on-scroll-down = "wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%-";
      on-click-right = "pavucontrol";
    };
  }
}
