## meta-zynqmp

Custom generic meta-layer for zynqmp boards.

Only tested with a zcu102 dev board.

Things that go in this layer

* kernel / driver customization
* u-boot customization
* PMU customization
* PMU config object fetch package (uses default from embeddedsw repo)
* FPGA bitstream fetch package (not written)
* userland board specific packages

Setup a build directory

  build/
      conf/
          local.conf
          bblayers.conf
          multiconfig/
              pmu.conf

Examples for local.conf, bblayers.conf and pmu.conf are provided.

Requires:

    URI: git://git.yoctoproject.org/poky.git
    branch: zeus

    URI: git://git.openembedded.org/meta-openembedded
    branch: zeus

    URI: git://git.yoctoproject.org/meta-security.git
    branch: zeus

    URI: https://github.com/Xilinx/meta-xilinx
    branch: zeus

    URI: https://github.com/jumpnow/meta-jumpnow.git
    branch: zeus

Latest commits:

    poky 74f229160c
    meta-openembedded 9e60d3066
    meta-security ecd8c30
    meta-xilinx b82343a
    meta-jumpnow f04724d


meta-zynqmp layer maintainer: Scott Ellis <scott@jumpnowtek.com>


The following patch is required to poky.git [zeus] branch for the pmu firmware build.

    diff --git a/meta/conf/machine/include/microblaze/feature-microblaze-versions.inc b/meta/conf/machine/include/microblaze/feature-microblaze-versions.inc
    index 955674fff9..3221e2aab7 100644
    --- a/meta/conf/machine/include/microblaze/feature-microblaze-versions.inc
    +++ b/meta/conf/machine/include/microblaze/feature-microblaze-versions.inc
    @@ -44,6 +44,7 @@ TUNEVALID[v9.4]  = "MicroBlaze version 9.4"
     TUNEVALID[v9.5]  = "MicroBlaze version 9.5"
     TUNEVALID[v9.6]  = "MicroBlaze version 9.6"
     TUNEVALID[v10.0] = "MicroBlaze version 10.0"
    +TUNEVALID[v11.0] = "MicroBlaze version 11.0"

     # Version conflict matrix
     TUNECONFLICTS[v8.00] = ""
    @@ -60,6 +61,7 @@ TUNECONFLICTS[v9.4]  = "v8.00 v8.10 v8.20 v8.30 v8.40 v8.50 v9.0 v9.1 v9.2 v9.3"
     TUNECONFLICTS[v9.5]  = "v8.00 v8.10 v8.20 v8.30 v8.40 v8.50 v9.0 v9.1 v9.2 v9.3 v9.4"
     TUNECONFLICTS[v9.6]  = "v8.00 v8.10 v8.20 v8.30 v8.40 v8.50 v9.0 v9.1 v9.2 v9.3 v9.4 v9.5"
     TUNECONFLICTS[v10.0] = "v8.00 v8.10 v8.20 v8.30 v8.40 v8.50 v9.0 v9.1 v9.2 v9.3 v9.4 v9.5 v9.6"
    +TUNECONFLICTS[v11.0] = "v8.00 v8.10 v8.20 v8.30 v8.40 v8.50 v9.0 v9.1 v9.2 v9.3 v9.4 v9.5 v9.6 v10.0"

     # Version flags
     TUNE_CCARGS += "-mcpu=${@microblaze_current_version(d, True)}"


The patch is a backport from poky [master] and can be hand applied.
