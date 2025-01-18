let
  gpuIDs = [
    "10de:28e0"
    "10de:22be"
  ];
in
{ lib, ... }:
{
  specialisation."GPUPaththrough".configuration = {
    system.nixos.tags = [ "Nvidia-GPU-vfio" "NoXpad" ];
    boot.initrd.kernelModules = [
      # vifo
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];
    boot.kernelParams = [ 
      ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs) # vfio-pci
    ];
  };
}
