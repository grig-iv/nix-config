{...}: {
  services.redshift = {
    enable = false;
    temperature.night = 2800;
    latitude = 59.951828;
    longitude = 30.342980;
  };

  xsession.initExtra = ''
    systemctl --user stop redshift.service
  '';

  systemd.user.services.start-redshift = {
    Unit.Description = "start redshift";
    Install.WantedBy = ["hm-graphical-session.target"];
    Service.ExecStart = "systemctl --user start redshift.service";
  };

  systemd.user.timers.start-redshift = {
    Unit.Description = "start redshift";
    Install.WantedBy = ["timers.target"];
    Timer = {
      OnCalendar = [
        "Sun,Mon..Thu *-*-* 22:30:00"
        "Fri..Sat *-*-* 23:30:00"
      ];
      Unit = "start-redshift.service";
    };
  };
}
