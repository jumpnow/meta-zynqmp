FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://defconfig"

LINUX_VERSION_EXTENSION = "-jumpnow-${XILINX_RELEASE_VERSION}"
