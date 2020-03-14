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

    poky 04d71b42e7
    meta-openembedded bb65c27a7
    meta-security ecd8c30
    meta-xilinx b82343a
    meta-jumpnow 6869932


meta-zynqmp layer maintainer: Scott Ellis <scott@jumpnowtek.com>
