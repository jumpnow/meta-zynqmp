require linux-stable.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

KERNEL_CONFIG_COMMAND = "oe_runmake_call -C ${S} CC="${KERNEL_CC}" O=${B} olddefconfig"

COMPATIBLE_MACHINE = "zcu102-zynqmp"

KERNEL_DEVICETREE = "\
    xilinx/zynqmp-zcu102-rev1.1.dtb \
    xilinx/zynqmp-zcu102-rev1.0.dtb \
    xilinx/zynqmp-sck-kv-g-revA.dtb \
    xilinx/zynqmp-sck-kv-g-revB.dtb \
    xilinx/zynqmp-sm-k26-revA.dtb \
    xilinx/zynqmp-smk-k26-revA.dtb \
"

LINUX_VERSION = "5.19"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-stable-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "5.19.10"
SRCREV = "b80678c1e00a34f01bce79c27afb7555666f559f"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-${LINUX_VERSION}.y \
    file://defconfig \
"
