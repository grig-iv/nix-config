{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cudatoolkit
    cudaPackages.cudnn
    # cudaPackages.cuda-samples # suddenly broke
  ];

  environment.sessionVariables = {
    CUDA_ROOT = pkgs.cudatoolkit;
    CUDA_PATH = pkgs.cudatoolkit;
    CUDNN_LIB = pkgs.pkgs.cudaPackages.cudnn;
    CANDLE_NVCC_CCBIN = "${pkgs.gcc11}/bin/gcc";
  };
}
