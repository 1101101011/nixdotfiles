{ config, lib, pkgs, ... }:
{
  options = {
    myDunst.enable = lib.mkEnableOption "Enable Dunst notification daemon with custom Gruvbox-Plus-Dark theme";
  };
  config = lib.mkIf config.myDunst.enable {
    services.dunst = {
      enable = true;
      iconTheme = {
        size = "16x16";
        package = pkgs.gruvbox-plus-icons;
        name = "Gruvbox-Plus-Dark";
      };
      settings = {
        global = {
          alignment="left";
          bounce_freq=0;
          corner_radius=10;
          follow="mouse";
          font="JetBrains Mono 12";
          format=''<b>%s</b>\n%b'';
          frame_color="#00000000";
          frame_width=0;
          height=175;
          horizontal_padding=15;
          icon_corner_radius=5;
          icon_corners="all";
          icon_position="left";
          idle_threshold=120;
          ignore_newline="no";
          indicate_hidden="yes";
          line_height=0;
          markup="full";
          max_icon_size=70;
          min_icon_size=70;
          monitor=0;
          mouse_left_click="close_current";
          mouse_middle_click="do_action, close_current";
          mouse_right_click="close_all";
          notification_limit=200;
          offset="0x10";
          origin="top-center";
          padding=15;
          progress_bar="yes";
          progress_bar_corner_radius=5;
          progress_bar_frame_width=1;
          progress_bar_height=10;
          progress_bar_max_width=400;
          progress_bar_min_width=150;
          separator_color="#00000000";
          separator_height=10;
          show_age_threshold=60;
          sort="yes";
          stack_duplicates="no";
          startup_notification="no";
          sticky_history="yes";
          transparency=0;
          width=300;
          word_wrap="yes";
        };
        urgency_low = {
          background="#282828";
          foreground="#ebdbb2";
          timeout=5;
        };
        urgency_normal = {
          background="#282828";
          foreground="#ebdbb2";
          timeout=10;
        };
        urgency_critical = {
          background="#282828";
          foreground="#fb4934";
          timeout=30;
        };
      };
    };
  };
}
