LINUX_VERSION = "5.4"
LINUX_VERSION_EXTENSION = "-jumpnow"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${LINUX_VERSION}:"

require linux-dev.inc

KERNEL_CONFIG_COMMAND = "oe_runmake_call -C ${S} CC="${KERNEL_CC}" O=${B} olddefconfig"

COMPATIBLE_MACHINE = "zynqmp"

KERNEL_DEVICETREE = "\
    xilinx/zynqmp-zcu100-revC.dtb \
    xilinx/zynqmp-zcu102-rev1.0.dtb \
"

S = "${WORKDIR}/git"

PV = "5.4.0"
KBRANCH = "xlnx_rebase_v5.4"
SRCREV = "bb8c1c9c0b132b50f6199d2e8cfcf0157544e9cc"
SRC_URI = " \
    git://github.com/Xilinx/linux-xlnx.git;protocol=https;branch=${KBRANCH} \
    file://defconfig \
"
