#!/bin/bash

mnt=/mnt

if [ -z ${MACHINE} ]; then
    MACHINE="zcu102-zynqmp"
fi

if [ "x${1}" = "x" ]; then
    echo -e "\nUsage: ${0} <block device> [ <image-type> [<hostname>] ]\n"
    exit 0
fi

mount | grep '^/' | grep -q "$1"

if [ $? -ne 1 ]; then
    echo "Looks like partitions on device /dev/${1} are mounted"
    echo "Not going to work on a device that is currently in use"
    mount | grep "$1"
    exit 1
fi

if [ ! -d "$mnt" ]; then
    echo "Temporary mount point [ $mnt ] not found"
    exit 1
fi

if [ "x${2}" = "x" ]; then
    image=console
else
    image="$2"
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

if [ ! -d "${OETMP}/deploy/images/${MACHINE}" ]; then
    echo "Directory not found: ${OETMP}/deploy/images/${MACHINE}"
    exit 1
fi

srcdir="${OETMP}/deploy/images/${MACHINE}"

echo "IMAGE: $image"

if [ "x${3}" = "x" ]; then
    target_hostname="$MACHINE"
else
    target_hostname="$3"
fi

echo "HOSTNAME: $target_hostname"

if [ -f "${srcdir}/${image}-image-${MACHINE}.tar.gz" ]; then
    rootfs="${srcdir}/${image}-image-${MACHINE}.tar.gz"
elif [ -f "${srcdir}/${image}-${MACHINE}.tar.gz" ]; then
    rootfs="${srcdir}/${image}-${MACHINE}.tar.gz"
elif [ -f "${srcdir}/${image}" ]; then
    rootfs="${srcdir}/${image}"
else
    echo "Rootfs file not found. Tried"
    echo " ${srcdir}/${image}-image-${MACHINE}.tar.gz"
    echo " ${srcdir}/${image}-${MACHINE}.tar.gz"
    echo " ${srcdir}/${image}"
    exit 1
fi

if [ -b "$1" ]; then
    dev="$1"
elif [ -b "/dev/${1}2" ]; then
    dev="/dev/${1}2"
elif [ -b "/dev/${1}p2" ]; then
    dev="/dev/${1}p2"
else
    echo "Block device not found: /dev/${1}2 or /dev/${1}p2"
    exit 1
fi

echo "Formatting $dev as ext4"
sudo mkfs.ext4 -q -L ROOT "$dev"

echo "Mounting $dev"
sudo mount "$dev" "$mnt"

echo "Extracting ${rootfs} ${mnt}"
sudo tar -C "$mnt" -xzf "$rootfs"

echo "Generating a random-seed for urandom"
mkdir -p "${mnt}/var/lib/systemd"
sudo dd status=none if=/dev/urandom of="${mnt}/var/lib/systemd/random-seed" bs=512 count=1
sudo chmod 600 "${mnt}/var/lib/systemd/random-seed"

echo "Writing current datetime to ${mnt}/etc/timestamp"
sudo -E bash -c "date +'%Y%m%d%H%M%S' > ${mnt}/etc/timestamp"

echo "Writing ${target_hostname} to ${mnt}/etc/hostname"
export target_hostname
export mnt
sudo -E bash -c "echo ${target_hostname} > ${mnt}/etc/hostname"

echo "Unmounting $dev"
sudo umount "$dev"

echo "Done"
