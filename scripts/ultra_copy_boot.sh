#!/bin/bash

if [ -z ${MACHINE} ]; then
    MACHINE="ultra96-zynqmp"
fi

if [ "${MACHINE}" == "ultra96-zynqmp" ]; then
    FILES="boot.bin uEnv.txt"
else
    echo "Unsupported MACHINE: $MACHINE"
    exit 1
fi

if [ "x${1}" = "x" ]; then
	echo "Usage: ${0} <block device>"
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

SRCDIR=.

for f in ${FILES}; do
    if [ ! -f ${SRCDIR}/${f} ]; then
        echo "File not found: ${SRCDIR}/${f}"
        exit 1
    fi
done

if [ -b ${1} ]; then
	DEV=${1}
elif [ -b "/dev/${1}1" ]; then
	DEV=/dev/${1}1
elif [ -b "/dev/${1}p1" ]; then
	DEV=/dev/${1}p1
else
	echo "Block device not found: /dev/${1}1 or /dev/${1}p1"
	exit 1
fi

echo "Formatting FAT partition on $DEV"
sudo mkfs.vfat ${DEV}

echo "Mounting $DEV"
sudo mount ${DEV} /media/card

for f in ${FILES}; do
    echo "Copying ${f}"
    sudo cp ${SRCDIR}/${f} /media/card

    if [ $? -ne 0 ]; then
        echo "Error copying file ${SRCDIR}${f}"
        sudo umount ${DEV}
        exit 1
    fi
done

echo "Unmounting ${DEV}"
sudo umount ${DEV}

echo "Done"

