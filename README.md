NOTE: Don't use!

This layer is not complete.

More work on the bootloader remains, should be completed this week.

The kernel and userland are okay (tested with Buildroot's 2022.02 bootloader).

The kernel config is vanilla, just 

    <linux-stable>/arch/arm64/configs/defconfig

with the non-zynqmp platforms removed. 


This layer depends on:

    URI: git://git.yoctoproject.org/poky.git
    branch: honister

    URI: git://git.openembedded.org/meta-openembedded
    branch: honister

    URI: git://git.yoctoproject.org/meta-security.git
    branch: honister

Latest commits:

    poky 580532cfd0
    meta-openembedded a19d1802b
    meta-security fb77606

meta-zynqmp layer maintainer: Scott Ellis <scott@jumpnowtek.com>
