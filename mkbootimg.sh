#!/bin/bash

OUTPUT_IMAGE=$1

TARGET_PREBUILT_KERNEL=$2
TARGET_PREBUILT_DTB=$3

RAMDISK_IMAGE=$4

RECOVERY_DTBO_ARGS=
if [[ ! -z "$5" ]]
then
RECOVERY_DTBO_ARGS="--recovery_dtbo "$5""
fi

BOARD_KERNEL_BASE=0x00000000
BOARD_KERNEL_PAGESIZE=4096
BOARD_KERNEL_CMDLINE="console=null androidboot.hardware=qcom androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 printk.devkmsg=on firmware_class.path=/vendor/firmware_mnt/image"

VENDOR_SECURITY_PATCH=2099-12-31

BOARD_KERNEL_OFFSET=0x00008000
BOARD_KERNEL_TAGS_OFFSET=0x01E00000
BOARD_KERNEL_SECOND_OFFSET=0x00F00000
BOARD_RAMDISK_OFFSET=0x02000000
BOARD_DTB_OFFSET=0x01F00000

TARGET_BOARD_NAME=RILSI26A001

bin/mkbootimg --kernel "$TARGET_PREBUILT_KERNEL" --output "$OUTPUT_IMAGE" \
--header_version 2 --os_version 10 \
--dtb "$TARGET_PREBUILT_DTB" $RECOVERY_DTBO_ARGS \
--ramdisk "$RAMDISK_IMAGE" \
--board $TARGET_BOARD_NAME \
--base $BOARD_KERNEL_BASE \
--pagesize $BOARD_KERNEL_PAGESIZE \
--cmdline "$BOARD_KERNEL_CMDLINE" \
--os_patch_level $VENDOR_SECURITY_PATCH \
--kernel_offset $BOARD_KERNEL_OFFSET \
--ramdisk_offset $BOARD_RAMDISK_OFFSET \
--dtb_offset $BOARD_DTB_OFFSET \
--tags_offset $BOARD_KERNEL_TAGS_OFFSET \
--second_offset $BOARD_KERNEL_SECOND_OFFSET
