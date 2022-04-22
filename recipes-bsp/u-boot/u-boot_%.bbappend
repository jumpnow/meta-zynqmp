FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://pm_cfg_obj.c"

DEPENDS += "arm-trusted-firmware pmufw"

inherit deploy

UBOOT_SUFFIX = "itb"

SPL_BINARY = "spl/boot.bin"

BL31 = "${DEPLOY_DIR_IMAGE}/bl31.bin"

EXTRA_OEMAKE:append = " BL31=${BL31}"

do_configure:append () {
    if [ -f ${B}/.config ]; then
        sed -i '/CONFIG_DEFAULT_DEVICE_TREE/c\CONFIG_DEFAULT_DEVICE_TREE="zynqmp-zcu102-rev1.0"' ${B}/.config
        sed -i '/CONFIG_OF_LIST/c\CONFIG_OF_LIST="zynqmp-zcu102-rev1.0"' ${B}/.config
        sed -i '/CONFIG_PMUFW_INIT_FILE/c\CONFIG_PMUFW_INIT_FILE="${DEPLOY_DIR_IMAGE}/pmufw.bin"' ${B}/.config
    fi

    if [ -f ${WORKDIR}/pm_cfg_obj.c ]; then
        ${S}/tools/zynqmp_pm_cfg_obj_convert.py ${WORKDIR}/pm_cfg_obj.c ${B}/pm_cfg_obj.bin
        sed -i '/CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE/c\CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE="${B}/pm_cfg_obj.bin"' ${B}/.config
    fi
}
