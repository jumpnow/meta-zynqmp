inherit deploy

DEPENDS += "u-boot-mkimage-native"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

ATF_VERSION_EXTENSION ?= "-xilinx"
PV = "${ATF_VERSION}${ATF_VERSION_EXTENSION}+git${SRCPV}"

REPO ?= "git://github.com/Xilinx/arm-trusted-firmware.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRC_URI = "${REPO};${BRANCHARG}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

PLATFORM = "zynqmp"

export CROSS_COMPILE="${TARGET_PREFIX}"

CFLAGS[unexport] = "1"
LDFLAGS[unexport] = "1"
AS[unexport] = "1"
LD[unexport] = "1"

do_configure() {
	oe_runmake clean -C ${S} BUILD_BASE=${B} PLAT=${PLATFORM}
}

do_compile() {
	oe_runmake -C ${S} BUILD_BASE=${B} ARM_ARCH_MAJOR=8 PLAT=${PLATFORM} RESET_TO_BL31=1 bl31
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${B}/zynqmp/release/bl31.bin ${DEPLOYDIR}/bl31.bin
}

addtask deploy before do_build after do_compile
