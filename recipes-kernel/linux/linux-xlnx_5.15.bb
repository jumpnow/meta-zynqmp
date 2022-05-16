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
SRCREV = "9ef3be1de28ec61f4dad2b16b1097b7e2270a5a6"
SRC_URI = " \
    git://github.com/Xilinx/linux-xlnx.git;protocol=https;branch=xlnx_rebase_v5.15_LTS \
    file://defconfig \
"
