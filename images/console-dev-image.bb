SUMMARY = "A console development image for the zynqmp"

require console-image.bb

DEV_SDK = " \
    binutils binutils-symlinks \
    coreutils \
    cpp cpp-symlinks \
    diffutils \
    elfutils elfutils-binutils \
    file \
    gcc gcc-symlinks \
    gdb \
    g++ g++-symlinks \
    gettext \
    git \
    ldd \
    libstdc++ libstdc++-dev \
    libtool \
    make \
    perl-modules \
    pkgconfig \
    python3-modules \
"

SECURITY_TOOLS = " \
    checksec \
    nmap \
"

IMAGE_INSTALL += " \
    ${DEV_SDK} \
    ${SECURITY_TOOLS} \
"

export IMAGE_BASENAME = "console-dev-image"
