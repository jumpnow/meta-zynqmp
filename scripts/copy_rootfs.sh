#!/bin/bash

DTB="zynq-zc706.dtb"

if [ -z ${MACHINE} ]; then
    MACHINE="zcu102-zynqmp"
fi

if [ "x${1}" = "x" ]; then
    echo -e "\nUsage: ${0} <block device> [ <image-type> [<hostname>] ]\n"
    exit 0
fi

mount | grep '^/' | grep -q ${1}

if [ $? -ne 1 ]; then
    echo "Looks like partitions on device /dev/${1} are mounted"
    echo "Not going to work on a device that is currently in use"
    mount | grep ${1}
    exit 1
fi

if [ ! -d /media/card ]; then
    echo "Temporary mount point [/media/card] not found"
    exit 1
fi

if [ "x${2}" = "x" ]; then
    image=console
else
    image=${2}
fi

if [ -z "$OETMP" ]; then
    # echo try to find it
    if [ -f ../../build/conf/local.conf ]; then
        OETMP=$(grep '^TMPDIR' ../../build/conf/local.conf | awk '{ print $3 }' | sed 's/"//g')

        if [ -z "$OETMP" ]; then
            OETMP=../../build/tmp
        fi
    fi
fi

if [ -z "$OETMP" ]; then
    echo "Environment variable OETMP not set"
    exit 1
fi

echo "OETMP: $OETMP"

if [ ! -d ${OETMP}/deploy/images/${MACHINE} ]; then
    echo "Directory not found: ${OETMP}/deploy/images/${MACHINE}"
    exit 1
fi

SRCDIR=${OETMP}/deploy/images/${MACHINE}

echo "IMAGE: $image"

if [ "x${3}" = "x" ]; then
    TARGET_HOSTNAME=${MACHINE}
else
    TARGET_HOSTNAME=${3}
fi

echo "HOSTNAME: $TARGET_HOSTNAME"

if [ -f "${SRCDIR}/${image}-image-${MACHINE}.tar.gz" ]; then
    rootfs=${SRCDIR}/${image}-image-${MACHINE}.tar.gz
elif [ -f "${SRCDIR}/${image}-${MACHINE}.tar.gz" ]; then
    rootfs=${SRCDIR}/${image}-${MACHINE}.tar.gz
elif [ -f "${SRCDIR}/${image}" ]; then
    rootfs=${SRCDIR}/${image}
else
    echo "Rootfs file not found. Tried"
    echo " ${SRCDIR}/${image}-image-${MACHINE}.tar.gz"
    echo " ${SRCDIR}/${image}-${MACHINE}.tar.gz"
    echo " ${SRCDIR}/${image}"
    exit 1
fi

if [ -b ${1} ]; then
    DEV=${1}
elif [ -b "/dev/${1}2" ]; then
    DEV=/dev/${1}2
elif [ -b "/dev/${1}p2" ]; then
    DEV=/dev/${1}p2
else
    echo "Block device not found: /dev/${1}2 or /dev/${1}p2"
    exit 1
fi

echo "Formatting $DEV as ext4"
sudo mkfs.ext4 -q -L ROOT $DEV

echo "Mounting $DEV"
sudo mount $DEV /media/card

echo "Extracting ${rootfs} /media/card"
sudo tar -C /media/card -xzf ${rootfs}

echo "Generating a random-seed for urandom"
mkdir -p /media/card/var/lib/systemd
sudo dd if=/dev/urandom of=/media/card/var/lib/systemd/random-seed bs=512 count=1
sudo chmod 600 /media/card/var/lib/systemd/random-seed

echo "Writing ${TARGET_HOSTNAME} to /etc/hostname"
export TARGET_HOSTNAME
sudo -E bash -c 'echo ${TARGET_HOSTNAME} > /media/card/etc/hostname'

if [ -f ./interfaces ]; then
    echo "Writing ./interfaces to /media/card/etc/network/"
    sudo cp ./interfaces /media/card/etc/network/interfaces
fi

echo "Unmounting $DEV"
sudo umount $DEV

echo "Done"

