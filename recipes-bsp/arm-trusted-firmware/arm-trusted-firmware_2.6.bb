DESCRIPTION = "ARM Trusted Firmware"

PROVIDES = "virtual/arm-trusted-firmware"

ATF_VERSION = "2.6"
SRCREV = "09438da10a8556de0a9be8b2484ba789f97aab02"
BRANCH = "master"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.rst;md5=1dd070c98a281d18d9eefd938729b031"

COMPATIBLE_MACHINE = "zcu102-zynqmp"

include arm-trusted-firmware.inc

