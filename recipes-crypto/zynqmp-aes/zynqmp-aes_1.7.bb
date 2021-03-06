SUMMARY = "Utilities to work with the zynqmp-aes driver"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "git://github.com/scottellis/zynqmp-aes.git;rev=${PV}"

S = "${WORKDIR}/git"

TARGET_CC_ARCH += "${LDFLAGS}"

do_install() {
    install -d ${D}${bindir}
    install -m 755 dec ${D}${bindir}
    install -m 755 enc ${D}${bindir}

    install -d ${D}${datadir}/zynqmp-aes
    install -m 755 tests/*.sh ${D}${datadir}/zynqmp-aes
}

FILES_${PN} = "${bindir}"
FILES_${PN}-dev = "${datadir}"
