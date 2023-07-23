{config, ...}: {
  services.redshift = {
    enable = true;
    temperature.night = 3000;
    latitude = 59.951828;
    longitude = 30.342980;
  };
}
