SUMMARY = "A console development image"

require images/basic-dev-image.bb

IMAGE_INSTALL += " \
    mtd-utils \
"

export IMAGE_BASENAME = "console-image"
