SUMMARY = "Download pre-built ZynqMP PMU firmware"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

COMPATIBLE_MACHINE = "zcu102-zynqmp"

INHIBIT_DEFAULT_DEPS = "1"

SRC_URI = "https://github.com/lucaceresoli/zynqmp-pmufw-binaries/raw/v2021.2/bin/pmufw-v2021.2.bin"
SRC_URI[sha256sum] = "d0235bf0d67f19f4b745b3bb56831b331ee53005c1beae06007321ef9375fb73"

inherit deploy nopackages

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${WORKDIR}/pmufw-v2021.2.bin ${DEPLOYDIR}/pmufw.bin
}

addtask do_deploy after do_compile before do_build
