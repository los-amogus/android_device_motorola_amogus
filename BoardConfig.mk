# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DEVICE_PATH := device/motorola/amogus

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := 20
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Arch
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := cortex-a73
TARGET_CPU_VARIANT_RUNTIME := cortex-a73
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_VARIANT := cortex-a53
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Kernel
TARGET_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_CLANG_VERSION := r563880c
TARGET_KERNEL_LLVM_BINUTILS := false
TARGET_KERNEL_NO_GCC := false
TARGET_KERNEL_CONFIG := vendor/amogus_defconfig
TARGET_KERNEL_SOURCE := kernel/motorola/msm-4.14
BOARD_KERNEL_CMDLINE += \
    androidboot.boot_devices=soc/4744000.sdhci \
    androidboot.usbcontroller=4e00000.dwc3

# SELinux
BOARD_USE_ENFORCING_SELINUX := true
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# Partition information
TARGET_COPY_OUT_VENDOR := vendor
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_EROFS_PCLUSTER_SIZE := 262144
BOARD_RECOVERYIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs

## Build product image
TARGET_COPY_OUT_PRODUCT := product
BOARD_MOT_DYNAMIC_PARTITIONS_SIZE := 4458545152
BOARD_MOT_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product \
    vendor
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SUPER_PARTITION_SIZE := 8925478912
BOARD_SUPER_PARTITION_GROUPS := mot_dynamic_partitions

# Charging Control
$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/power_supply/battery/input_suspend)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_disabled,1)
$(call soong_config_set_bool,lineage_health,charging_control_supports_bypass,false)

# Bootanimation
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2300
TARGET_BOOTANIMATION_HALF_RES := true

# Recovery
RECOVERY_KERNEL_MODULES += \
    qpnp-smbcharger-mmi.ko \
    focaltech_0flash_mmi.ko \
    nova_0flash_mmi.ko
BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD += \
    qpnp-smbcharger-mmi.ko \
    focaltech_0flash_mmi.ko \
    nova_0flash_mmi.ko

# Vendor kernel modules loaded during early-init
BOARD_VENDOR_KERNEL_MODULES_LOAD := \
    qpnp-smbcharger-mmi.ko \
    stmvl53l1.ko \
    sx933x_sar.ko \
    aw8624.ko \
    aw8695.ko \
    focaltech_0flash_mmi.ko \
    nova_0flash_mmi.ko

include device/motorola/common/CommonConfig.mk
