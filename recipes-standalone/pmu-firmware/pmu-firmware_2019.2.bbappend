FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-Load-built-in-config-object-at-boot.patch"

do_configure_append() {
    # use the default pm_cfg_obj.c for now
    cp ${S}/../../zynqmp_fsbl/misc/pm_cfg_obj.c ${S}/pm_cfg_obj.c
    sed -i -e 's/XILPM_/PM_/g' ${S}/pm_cfg_obj.c
}
