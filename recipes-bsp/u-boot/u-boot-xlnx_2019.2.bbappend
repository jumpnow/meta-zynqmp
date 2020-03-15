FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

do_compile[mcdepends] = "multiconfig::pmu:pmu-firmware:do_deploy"

SRC_URI += "file://0001-Remove-unused-boot-options.patch"
