FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# overrides for the meta-xilinx-bsp zcu102-zynqmp MACHINE
UBOOT_MACHINE_zcu102-zynqmp = "xilinx_zynqmp_virt_defconfig"
SPL_BINARY_zcu102-zynqmp = ""

# Use the 2020.1 version of u-boot for all boards

UBRANCH = "master"
SRCREV = "e44c2bc102f4699e240f16e17999d7d7886042d7"

SRC_URI += "\
    file://0001-Add-zynqmp_zcu102x_defconfig.patch \
"

XILINX_RELEASE_VERSION = "2020.1"

HAS_PLATFORM_INIT = "\
    xilinx_zynqmp_virt_config \
    zynqmp_zcu102x_config \
"
