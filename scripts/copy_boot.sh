#!/bin/bash

mnt=/mnt

if [ -z ${MACHINE} ]; then
    MACHINE="zcu102-zynqmp"
fi

if [ "${MACHINE}" = "zcu102-zynqmp" ]; then
    files="boot.bin u-boot.itb boot.scr"
else
    echo "Unsupported MACHINE: $MACHINE"
    exit 1
fi

if [ "x${1}" = "x" ]; then
    echo "Usage: ${0} <block device>"
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

for f in $files; do
    if [ ! -f "${srcdir}/${f}" ]; then
        echo "File not found: ${srcdir}/${f}"
        exit 1
    fi
done

if [ -b "$1" ]; then
	dev="$1"
elif [ -b "/dev/${1}1" ]; then
	dev="/dev/${1}1"
elif [ -b "/dev/${1}p1" ]; then
	dev="/dev/${1}p1"
else
	echo "Block device not found: /dev/${1}1 or /dev/${1}p1"
	exit 1
fi

echo "Formatting FAT partition on $dev"
sudo mkfs.vfat "$dev"

echo "Mounting $dev"
sudo mount "$dev" "$mnt"

for f in $files; do
    echo "Copying $f"
    sudo cp "${srcdir}/${f}" "$mnt"

    if [ $? -ne 0 ]; then
        echo "Error copying file ${srcdir}${f}"
        sudo umount "$dev"
        exit 1
    fi
done

echo "Unmounting $dev"
sudo sync
sudo umount "$dev"

echo "Done"
