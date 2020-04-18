SUMMARY = "A console development image"

require images/basic-dev-image.bb

IMAGE_INSTALL += " \
    mtd-utils \
    ${SECURITY_TOOLS} \
    ${WIREGUARD} \
"

export IMAGE_BASENAME = "console-image"
