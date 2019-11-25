SUMMARY = "A console development image"

require console-image.bb

SDK = " \
    cpp cpp-symlinks \
    elfutils elfutils-binutils \
    gcc gcc-symlinks \
    g++ g++-symlinks \
    gettext \
    git \
    ldd \
    libstdc++ libstdc++-dev \
    libtool \
    ltrace \
    make \
    pkgconfig \
    python3-modules \
    strace \
"

USERLAND += " \
    curl libcurl \
    htop \
    iperf3 \
    netcat-openbsd \
    util-linux util-linux-blkid \
    wget \
"

SECURITY += " \
    python3-scapy \
"

IMAGE_INSTALL += " \
    ${SDK} \
"

export IMAGE_BASENAME = "console-dev-image"
