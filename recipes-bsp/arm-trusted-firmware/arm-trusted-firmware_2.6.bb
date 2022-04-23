DESCRIPTION = "ARM Trusted Firmware"

PROVIDES = "virtual/arm-trusted-firmware"

ATF_VERSION = "2.6"
SRCREV = "09438da10a8556de0a9be8b2484ba789f97aab02"
BRANCH = "master"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://licenses/LICENSE.MIT;md5=57d76440fc5c9183c79d1747d18d2410"

COMPATIBLE_MACHINE = "zcu102-zynqmp"

include arm-trusted-firmware.inc

