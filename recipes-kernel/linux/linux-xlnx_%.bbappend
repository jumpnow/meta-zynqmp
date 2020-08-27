LINUX_VERSION = "5.4"
KBRANCH = "xlnx_rebase_v5.4"
SRCREV = "bb8c1c9c0b132b50f6199d2e8cfcf0157544e9cc"
SRC_URI += "\
    file://defconfig \
    file://0001-zynqmp-aes-Return-negative-error-code-on-fail.patch \
"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${LINUX_VERSION}:"

# LINUX_VERSION_EXTENSION = "-${XILINX_RELEASE_VERSION}"
LINUX_VERSION_EXTENSION = "-jumpnow"
