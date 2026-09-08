{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        btop
      ];

      systemd.tmpfiles.rules = [
        "Z /sys/class/powercap/intel-rapl:0/energy_uj 0444 root root - -"
      ];
    };

  flake.modules.homeManager.princedimond-cli =
    { pkgs, ... }:
    {
      programs.btop = {
        enable = true;
        package = pkgs.btop.override {
          rocmSupport = true;
          cudaSupport = true;
        };

        settings = {

          presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
          graph_symbol = "braille";
          shown_boxes = "net proc cpu mem";
          update_ms = 2000;
          proc_sorting = "memory";
          proc_tree = true;
          proc_colors = true;
          proc_gradient = true;
          cpu_graph_upper = "total";
          cpu_graph_lower = "idle";
          show_uptime = true;
          check_temp = true;
          show_coretemp = false;
        };
      };
    };
}
