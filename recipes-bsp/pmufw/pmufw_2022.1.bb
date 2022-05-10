SUMMARY = "Download pre-built ZynqMP PMU firmware"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

COMPATIBLE_MACHINE = "zcu102-zynqmp"

INHIBIT_DEFAULT_DEPS = "1"

SRC_URI = "https://github.com/lucaceresoli/zynqmp-pmufw-binaries/raw/v${PV}/bin/pmufw-v${PV}.bin"
SRC_URI[sha256sum] = "5847d6c8c4bdc6c508d64f9840bee30684b5a40fb05dc1c9f00ab38da2d9fb30"

inherit deploy nopackages

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${WORKDIR}/pmufw-v${PV}.bin ${DEPLOYDIR}/pmufw.bin
}

addtask do_deploy after do_compile before do_build
