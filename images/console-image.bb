SUMMARY = "A console development image"

require images/basic-dev-image.bb

WIFI = " \
    crda \
    iw \
    linux-firmware-ralink \
    wpa-supplicant \
"

IMAGE_INSTALL += " \
    mtd-utils \
    valgrind \
    zynqmp-aes-dev \
    ${WIFI} \
"

export IMAGE_BASENAME = "console-image"
