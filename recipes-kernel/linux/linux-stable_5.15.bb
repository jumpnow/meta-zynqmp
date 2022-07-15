require linux-stable.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

KERNEL_CONFIG_COMMAND = "oe_runmake_call -C ${S} CC="${KERNEL_CC}" O=${B} olddefconfig"

COMPATIBLE_MACHINE = "zcu102-zynqmp"

KERNEL_DEVICETREE = "\
    xilinx/zynqmp-zcu102-rev1.1.dtb \
    xilinx/zynqmp-zcu102-rev1.0.dtb \
"

LINUX_VERSION = "5.15"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-stable-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "5.15.55"
SRCREV = "baefa2315cb1371486f6661a628e96fa3336f573"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-${LINUX_VERSION}.y \
    file://defconfig \
"
