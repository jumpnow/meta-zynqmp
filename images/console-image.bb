SUMMARY = "A console image with a standard userland"

IMAGE_FEATURES += "package-management"
IMAGE_LINGUAS = "en-us"

inherit image

CORE = " \
    openssh openssh-keygen openssh-sftp-server \
    packagegroup-core-boot \
    rndaddtoentcnt \
    tzdata \
"

KERNEL = " \
    cryptodev-module \
    kernel-modules \
    load-modules \
"

USERLAND = " \
    binutils binutils-symlinks \
    bzip2 \
    coreutils \
    diffutils \
    dosfstools \
    e2fsprogs-mke2fs \
    ethtool \
    file \
    findutils \
    grep \
    i2c-tools \
    ifupdown \
    iproute2 \
    iptables \
    less \
    mtd-utils mtd-utils-ubifs \
    ntp ntp-tickadj ntp-utils \
    procps \
    rpcbind \
    rsyslog \
    sysfsutils \
    util-linux util-linux-blkid \
    unzip \
"

SECURITY = " \
    checksec \
"

IMAGE_INSTALL += " \
    ${CORE} \
    ${KERNEL} \
    ${USERLAND} \
    ${SECURITY} \
"

IMAGE_FILE_BLACKLIST += " \
    /etc/init.d/hwclock.sh \
"

remove_blacklist_files() {
    for i in ${IMAGE_FILE_BLACKLIST}; do
        rm -rf ${IMAGE_ROOTFS}$i
    done
}

set_local_timezone() {
    ln -sf /usr/share/zoneinfo/EST5EDT ${IMAGE_ROOTFS}/etc/localtime
}

create_opt_dir() {
    mkdir -p ${IMAGE_ROOTFS}/opt
}

disable_bootlogd() {
    echo BOOTLOGD_ENABLE=no > ${IMAGE_ROOTFS}/etc/default/bootlogd
}

disable_rngd() {
    rm -f ${IMAGE_ROOTFS}/etc/rcS.d/S*rng-tools
    rm -f ${IMAGE_ROOTFS}/etc/rc5.d/S*rng-tools
}

ROOTFS_POSTPROCESS_COMMAND += " \
    remove_blacklist_files ; \
    set_local_timezone ; \
    disable_bootlogd ; \
    disable_rngd ; \
    create_opt_dir ; \
"

export IMAGE_BASENAME = "console-image"
