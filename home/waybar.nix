{ pkgs, ... }:

{
  stylix.targets.waybar.enable = false;

  home.packages = with pkgs; [
    playerctl
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [{
      layer = "bottom";
      reload_style_on_change = true;
      # height = 36;

      modules-left = ["sway/workspaces" "mpris"];
      modules-center = ["sway/window"];
      modules-right = [
        "sway/language"
        "network"
        "battery"
        "wireplumber"
        "bluetooth"
        "tray"
        "clock"
      ];

      "sway/workspaces" = {
        swap-icon-label = false;
        disable-scroll = false;
        all-outputs = true;
        format = "{icon}";
      };

      mpris = {
        format = "<b>{status_icon}</b>: {dynamic}";
        interval = 0.3;
        max-length = 64;
        status-icons = {
          playing = "Now playing";
          paused = "Paused";
        };
        dynamic-order = ["artist" "title"];
        tooltip = false;
      };

      "sway/window" = {
        all-outputs = true;
        format = "{title}";
        max-length = 48;
        tooltip = false;
      };

      clock = {
        interval = 60;
        format = "{:%R}";
        tooltip-format = "{calendar}";
        calendar = {
          mode-mon-col = 3;
          format = {
            months = "<b>{}</b>";
            days = "{}";
            weeks = "<b>{:%W}</b>";
            weekdays = "<b>{}</b>";
            today = "<b><u>{}</u></b>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

      network = {
        format-wifi = "<b>Net:</b> {essid}";
        format-ethernet = "<b>Net:</b> Ethernet";
        format-disconnected = "<b>Net:</b> Down";
        tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
        tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
        tooltip-format-disconnected = "Disconnected";
      };

      battery = {
        format = "<b>Battery:</b> {capacity}%";
        format-charging = "<b>Battery:</b> {capacity}%*";
        interval = 60;
        states = {
          warning = 20;
          critical = 10;
        };
        tooltip = "false";
      };

      "sway/language" = {
        on-double-click = "systemctl restart --user waybar.service";
        format = "<b>Lang:</b> {shortDescription}";
      };

      wireplumber = {
        on-click = "pavucontrol";
        on-click-right = "wpctl set-mute @DEFAULT_SINK@ toggle";
        format = "<b>Volume:</b> {volume}%";
        format-muted = "<b>Volume:</b> muted";
        max-volume = 100;
        scroll-step = 5;
        tooltip = "false";
      };

      bluetooth = {
        format = "";
        format-connected = "@ Bluetooth";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
      };

      tray = {
        icon-size = 16;
        spacing = 10;
        tooltip = false;
      };
    }];

    style = ''
      window#waybar {
        background: #000000;
        background: linear-gradient(180deg, rgba(0, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0) 100%);
        color: #fff;
      }

      * {
        font-family: "Liberation Serif", serif;
        font-size: 15px;
      }

      .module {
        padding: 0 4px 0 4px;
      }

      .modules-left {
        margin-left: 8px;
      }

      .modules-right {
        margin-right: 8px;
      }

      /* pizdec nachinayetsa */

      #workspaces button:first-child {
        margin: 6px 2px 6px 0;
      }

      #workspaces button:last-child {
        margin: 6px 0px 6px 2px;
      }

      #workspaces button {
        min-width: 0;
        min-height: 0;

        padding: 2px 7px;
        margin: 6px 2px 6px 2px;

        /* pizdec konchilsya */

        color: #fff;
        background-color: transparent;
      }

      #workspaces button:hover,
      #workspaces button.active,
      #workspaces button.focused {
        color: #000;
        background-color: #fff;
      }
    '';
  };
}
