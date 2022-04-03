#!/bin/bash

if [ -n "$1" ]; then
    DEV=/dev/$1
else
    echo "Usage: sudo $0 <device>"
    echo "Example: sudo $0 sdb"
    exit 1
fi

mount | grep '^/' | grep -q ${1}

if [ $? -ne 1 ]; then
    echo "Looks like partitions on device /dev/${1} are mounted"
    echo "Not going to work on a device that is currently in use"
    mount | grep ${1}
    exit 1
fi

echo "Working on $DEV"

#make sure that the SD card isn't mounted before we start
if [ -b ${DEV}1 ]; then
    umount ${DEV}1
    umount ${DEV}2
elif [ -b ${DEV}p1 ]; then
    umount ${DEV}p1
    umount ${DEV}p2
else
    umount ${DEV}
fi

SIZE=$(fdisk -l $DEV | grep "$DEV" | cut -d' ' -f5 | grep -o -E '[0-9]+')

echo DISK SIZE – $SIZE bytes

if [ "$SIZE" -lt 3600000000 ]; then
    echo "Require an SD card at least 4GB"
    exit 1
fi

echo "Okay, here we go ..."

echo "=== Zeroing the MBR ==="
dd if=/dev/zero of=$DEV bs=1024 count=1024

# Minimum required 2 partitions
# Sectors are 512 bytes
# 0     : 1MB, no partition, MBR then empty
# 2048  : 128 MB, FAT partition, bootloader
# 264192: 2GB+, linux partition, root filesystem

echo "=== Creating 2 partitions ==="
{
echo 2048,262144,0xC,*
echo 264192,+,0x83,-
} | sfdisk $DEV

sleep 1

echo "=== Done! ==="
