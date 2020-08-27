FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LIC_FILES_CHKSUM = "file://../../../../license.txt;md5=8b565227e1264d677db8f841c2948cba"

XILINX_RELEASE_VERSION = "v2020.1"
SRCREV = "338150ab3628a1ea6b06e964b16e712b131882dd"

SRC_URI += "file://0001-Load-built-in-config-object-at-boot.patch"

do_configure_append() {
    # use the default pm_cfg_obj.c for now
    cp ${S}/../../zynqmp_fsbl/misc/pm_cfg_obj.c ${S}/pm_cfg_obj.c
    sed -i -e 's/XILPM_/PM_/g' ${S}/pm_cfg_obj.c
}
