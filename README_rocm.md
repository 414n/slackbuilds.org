# AMD ROCm

## TODO

 - [x] fix DOWNLOAD/MD5SUM -> DOWNLOAD_x86_64/MD5SUMX_x86_64 + DOWNLOAD=UNSUPPORTED e MD5SUM=""
 - [ ] fix slack-desc + README with fixed AMD ROCm prologue or not?
 - [ ] normalize treatment of `AMDGPU_TARGETS` variable across all SlackBuilds that use it during the build, translating it accordingly (i.e. `GPU_TARGETS`)
 - [ ] move all rocm packages to a more proper section than graphics/ ?
 - [ ] recompile all as `Release`. [MIOpen disables excessive log output when compiled as release](https://github.com/ROCm/MIOpen/blob/10250d6bcdaef2767d4886b839f639938d15e9e5/docs/DebugAndLogging.md?plain=1#L24)
 - [ ] check every package with `sbolint`

# Ordered package list

 1. rocm-llvm
 2. hsakmt-roct
 3. rocm-cmake
 4. rocm-device-libs
 5. rocm-compiler-support (comgr)
 6. hsa-rocr
 7. rocminfo
 8. rocm-opencl-runtime
 9. python3-cppheaderparser (dependency for hip-runtime-amd, this is outside rocm)
 10. hip-runtime-amd
 11. hsa-amd-aqlprofile-bin (closed-source, non really necessary) <- debian has a patch to remove warnings that get printed out when his lib is not found at runtime
 12. rocrand
 13. rocm-core (metadata mainly for pytorch)
 14. rocblas
 15. rocprim
 16. hipcub
 17. rocsparse
 18. hipsparse
 19. rocsolver
 20. hipblas
 21. rocm-clang-ocl
 22. composable-kernel
 23. half (dependency for miopen, this is outside rocm)
 24. miopengemm
 25. miopen-hip
 26. rocfft
 27. hipfft
 28. rocthrust
 29. hipsolver
 30. rocm-smi-lib
 31. hipify-clang
 32. rccl
 33. roctracer