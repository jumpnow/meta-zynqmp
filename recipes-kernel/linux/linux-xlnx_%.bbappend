FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "b983d5fd71d4feaf494cdbe0593ecc29ed471cb8"
SRC_URI += "\
    file://0001-Revert-f318ac06-Add-no-1-8-v-property.patch \
    file://defconfig \
"

LINUX_VERSION_EXTENSION = "-jumpnow-${XILINX_RELEASE_VERSION}"
