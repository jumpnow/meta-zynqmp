require linux-stable.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

KERNEL_CONFIG_COMMAND = "oe_runmake_call -C ${S} CC="${KERNEL_CC}" O=${B} olddefconfig"

COMPATIBLE_MACHINE = "zcu102-zynqmp"

KERNEL_DEVICETREE = "\
    xilinx/zynqmp-zcu102-rev1.0.dtb \
"

LINUX_VERSION = "5.15"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-xlnx-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "5.15.0"
SRCREV = "1caa8c4ad39f5d93fb18b4fcb85de07b037d4da3"
SRC_URI = " \
    git://github.com/Xilinx/linux-xlnx.git;protocol=https;branch=xlnx_rebase_v5.15 \
    file://defconfig \
"
