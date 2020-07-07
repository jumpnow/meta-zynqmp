SUMMARY = "A library allowing user-space access to the Linux kernel crypto API"
HOMEPAGE = "https://github.com/lathiat/nss-mdns"
SECTION = "libs"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://COPYING;md5=c78be93ed8d1637f2a3f4a83ff9d5f54"

SRC_URI = "git://github.com/smuellerDD/libkcapi.git"
SRCREV = "f0576a6106bbb208045e8fdfe77afacfab7cce21"

PACKAGECONFIG[kcapi-test] = "--enable-kcapi-test"
PACKAGECONFIG[kcapi-speed] = "--enable-kcapi-speed"
PACKAGECONFIG[kcapi-hasher] = "--enable-kcapi-hasher"
PACKAGECONFIG[kcapi-rngapp] = "--enable-kcapi-rngapp"
PACKAGECONFIG[kcapi-encapp] = "--enable-kcapi-encapp"
PACKAGECONFIG[kcapi-dgstapp] = "--enable-kcapi-dgstapp"

PACKAGECONFIG ??= "\
    kcapi-test \
    kcapi-speed \
    kcapi-encapp \
"

EXTRA_OECONF = "--disable-lib-asym --disable-lib-kpp"

S = "${WORKDIR}/git"

inherit autotools pkgconfig

RDEPENDS_${PN} = "bash"

FILES_${PN} = "${bindir} ${libdir} ${libexecdir}"
