## meta-zynqmp

Custom generic meta-layer for zynqmp boards.

Tested with

* Xilinx ZCU102 dev board
* Avnet Ultra96v2 board

Setup a build directory

  build/
      conf/
          local.conf
          bblayers.conf
          multiconfig/
              pmu.conf

Examples for local.conf, bblayers.conf and pmu.conf are provided under conf/.

Requires:

    URI: git://git.yoctoproject.org/poky.git
    branch: zeus

    URI: git://git.openembedded.org/meta-openembedded
    branch: zeus

    URI: git://git.yoctoproject.org/meta-security.git
    branch: zeus

    URI: https://github.com/Xilinx/meta-xilinx
    branch: zeus

    URI: git://github.com/Xilinx/meta-xilinx-tools.git
    branch: rel-v2020.1

    URI: https://github.com/jumpnow/meta-jumpnow.git
    branch: zeus

Latest commits:

    poky ecd64bc63d
    meta-openembedded 2b5dd1eb8
    meta-security 440c37f
    meta-xilinx b82343a
    meta-xilinx-tools dce26f5
    meta-jumpnow 1c39af3


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
