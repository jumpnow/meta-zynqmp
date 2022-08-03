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

PV = "5.15.36"
SRCREV = "66563d3cfa2cefa11ea7160f7fb6ba499c1fc8a1"
SRC_URI = " \
    git://github.com/Xilinx/linux-xlnx.git;protocol=https;branch=xlnx_rebase_v5.15_LTS \
    file://defconfig \
"
