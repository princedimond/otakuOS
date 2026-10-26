{ ... }:
{
  flake.modules.homeManager.niri = {
    xdg.configFile."niri/monitors.kdl".text = ''
      // You can configure outputs by their name, which you can find
      // by running `niri msg outputs` while inside a niri instance.
      output "eDP-1" {
          // Uncomment this line to disable this output.
          // off

          // The format is "<width>x<height>" or "<width>x<height>@<refresh rate>".
          // Run `niri msg outputs` while inside a niri instance to list all outputs and their modes.
          mode "1920x1080"

          scale 1

          // Transform allows to rotate the output counter-clockwise, valid values are:
          // normal, 90, 180, 270, flipped, flipped-90, flipped-180 and flipped-270.
          transform "normal"

          // Position of the output in the global coordinate space.
          // This affects directional monitor actions like "focus-monitor-left", and cursor movement.
          // The cursor can only move between directly adjacent outputs.
          // Output scale and rotation has to be taken into account for positioning:
          // outputs are sized in logical, or scaled, pixels.
          // For example, a 3840×2160 output with scale 2.0 will have a logical size of 1920×1080,
          // so to put another output directly adjacent to it on the right, set its x to 1920.
          // If the position is unset or results in an overlap, the output is instead placed
          // automatically.
          position x=0 y=0
      }
    '';
  };
}
