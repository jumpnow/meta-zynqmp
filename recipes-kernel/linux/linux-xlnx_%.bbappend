# 5.4
LINUX_VERSION = "5.4"
KBRANCH = "xlnx_rebase_v5.4"
SRCREV = "22b71b41620dac13c69267d2b7898ebfb14c954e"
SRC_URI += "\
    file://defconfig \
    file://0001-zynqmp-aes-Return-negative-error-code-on-fail.patch \
"

# 4.19
#SRCREV = "b983d5fd71d4feaf494cdbe0593ecc29ed471cb8"
#SRC_URI += "
#    file://0001-Revert-f318ac06-Add-no-1-8-v-property.patch
#"
#    file://defconfig 

# 4.14
#LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"
#LINUX_VERSION = "4.14"
#KBRANCH = "xlnx_rebase_v4.14"

# this is the v2018.3 rev
#SRCREV = "eeab73d1207d6fc2082776c954eb19fd7290bfbe"
# this is the v2018.2 rev
#SRCREV = "ad4cd988ba86ab0fb306d57f244b7eaa6cce79a4"
#SRC_URI += "\
#    file://defconfig \
#    file://0001-Add-zynqmp-aes-module.patch \
#"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${LINUX_VERSION}:"

LINUX_VERSION_EXTENSION = "-jumpnow-${XILINX_RELEASE_VERSION}"
