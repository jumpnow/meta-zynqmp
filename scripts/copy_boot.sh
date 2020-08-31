#!/bin/bash

if [ -z ${MACHINE} ]; then
    # try to find it
    if [ -f ../../build/conf/local.conf ]; then
        MACHINE=$(grep '^MACHINE' ../../build/conf/local.conf | grep -v MACHINE_ | awk '{ print $3 }' | sed 's/"//g')
    fi

    if [ -z "${MACHINE}" ]; then
        echo "Environment variable MACHINE not set"
        echo "Example: export MACHINE=raspberrypi4|raspberrypi3|raspberrypi0-wifi"
        exit 1
    fi
fi

if [ "${MACHINE}" = "zcu102-zynqmp" ]; then
    FILES="boot.bin"
    UENV=zynqmp-zcu102-rev1.0.dtb
elif [ "${MACHINE}" = "db-zynqmp" ]; then
    FILES="boot.bin"
    UENV=zynqmp-zcu102-rev1.0.dtb
elif [ "${MACHINE}" = "ultra96-zynqmp" ]; then
    FILES="boot.bin"
    UENV=zynqmp-zcu100-revC.dtb
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

if [ -z "$OETMP" ]; then
    if [ -d "../../build/tmp" ]; then
        OETMP="../../build/tmp"
    fi
fi

echo "MACHINE: $MACHINE"
echo "OETMP: $OETMP"

if [ ! -d ${OETMP}/deploy/images/${MACHINE} ]; then
    echo "Directory not found: ${OETMP}/deploy/images/${MACHINE}"
    exit 1
fi

SRCDIR=${OETMP}/deploy/images/${MACHINE}

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

if [ -f ./uEnv.txt ]; then
    echo "Fixing up uEnv.txt in /tmp"
    cp ./uEnv.txt /tmp/uEnv.txt
    sed -i "s:^dtb=.*:dtb=${UENV}:" /tmp/uEnv.txt
    echo "Copying /tmp/uEnv.txt"
    sudo cp /tmp/uEnv.txt /media/card/uEnv.txt
else
    echo "No uEnv.txt found"
fi


echo "Unmounting ${DEV}"
sudo umount ${DEV}

echo "Done"

