{ pkgs, config, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "/media/data/music";
    dataDir = "${config.xdg.configHome}/mpd";
    network.startWhenNeeded = true;
    extraConfig = ''
    	max_output_buffer_size	"8192"
    	audio_output {
    		type		"pipewire"
    		name		"pipewire output"
    	}
    '';
  };

  services.mpd-mpris = {
    enable = true;
    mpd = {
      host = "localhost";
      port = 6600;
    };
  };

  programs.ncmpcpp = {
    enable = true;
    settings = {
      lyrics_directory = "${config.xdg.dataHome}/lyrics";
      message_delay_time = "2";
      browser_sort_mode = "format";
      browser_sort_format = "{%t - }|{%f - }{%a}";
      song_columns_list_format = "(30)[154]{t} (30)[154]{a} (30)[154]{b} (7)[154]{l}";
      song_status_format = "$b{{$8\"%t\"}} $3by {$4%a{ $3in $7%b{ (%y)}} $3}|{$8%f}";
      song_library_format = "{%n - }{%t}|{%f}";
      alternative_header_first_line_format = "$b{%t}|{%f}$/b";
      alternative_header_second_line_format = "{{$5$b%a$/b$9}{ - $5%b$9}}|{%f}";
      selected_item_prefix = "$6";
      selected_item_suffix = "$9";
      current_item_prefix = "$(cyan)$r$b";
      current_item_suffix = "$/r$(end)$/b";
      current_item_inactive_column_prefix = "$(magenta)$r";
      current_item_inactive_column_suffix = "$/r$(end)";
      now_playing_prefix = "$(154) » $9";
      now_playing_suffix = "";
      user_interface = "alternative";
      header_visibility = "no";
      statusbar_visibility = "no";
      titles_visibility = "yes";
      header_text_scrolling = "no";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      progressbar_look = "─╼";
      media_library_primary_tag = "album_artist";
      media_library_albums_split_by_date = "no";
      startup_screen = "browser";
      display_volume_level = "yes";
      ignore_leading_the = "yes";
      external_editor = "nvim";
      use_console_editor = "yes";
      empty_tag_color = "magenta";
      main_window_color = "white";
      allow_for_physical_item_deletion = "yes";
      progressbar_color = "black:b";
      progressbar_elapsed_color = "blue:b";
      statusbar_color = "red";
      statusbar_time_color = "cyan:b";
    };
  };
}
