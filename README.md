## meta-idexx-zynqmp

Custom meta-layer for zynqmp boards.

Only tested with a zcu102 dev board.

Things that go in this layer 

* kernel / driver customization 
* u-boot customization 
* PMU customization
* PMU config object fetch package (now written)
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
    branch: warrior

    URI: git://git.openembedded.org/meta-openembedded
    branch: warrior

    URI: git://git.yoctoproject.org/meta-security.git
    branch: warrior

    URI: https://github.com/Xilinx/meta-xilinx
    branch: warrior

Latest commits:

    poky c9a1a60
    meta-openembedded a24acf9
    meta-security 4f7be0d
    meta-xilinx 391c705

