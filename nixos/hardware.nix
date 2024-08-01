{
  pkgs,
  lib,
  config,
  ...
}:
{
  hardware = {
    graphics = {
      enable = true;
      # For Wine32 mostly
      enable32Bit = true;
      extraPackages = lib.attrValues {
        inherit (pkgs)
          mesa
          nvidia-vaapi-driver
          # For Encoding/Decoding Videos
          nv-codec-headers-12
          vulkan-loader
          ;
      };
      extraPackages32 = lib.attrValues { inherit (pkgs.driversi686Linux) mesa; };
    };

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.58";
        sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
        sha256_aarch64 = lib.fakeSha256;
        openSha256 = lib.fakeSha256;
        settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
        persistencedSha256 = lib.fakeSha256;
      };
    };
  };
}
