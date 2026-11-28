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

# Device path
PLATFORM_COMMON_PATH := device/motorola/amogus

# A/B support
AB_OTA_UPDATER := true
PRODUCT_SHIPPING_API_LEVEL := 29
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    recovery \
    system \
    vbmeta \
    vendor

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Dalvik heap
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Camera
TARGET_NEEDS_RAW10_BUFFER_FIX := true
TARGET_USES_64BIT_CAMERA := false

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.tof.direct=1

## Camera Requirements
PRODUCT_PACKAGES += \
    android.frameworks.displayservice@1.0 \
    libcamera_shim \
    libgbp_shim \
    libgui_vendor

# Device Characteristics
DEVICE_CHARACTERISTICS += fm erofs

# Device Folders
PRODUCT_PACKAGES += \
    amogus_folders

# Dynamic Partitions
TARGET_USES_DYNAMIC_PARTITIONS ?= true

# Fingerprint
TARGET_USES_EGISTEC_FINGERPRINT := true
TARGET_USES_FPC_FINGERPRINT := true

# Gatekeeper
PRODUCT_VENDOR_PROPERTIES += \
    vendor.gatekeeper.disable_spu=true

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.base@1.0.vendor

# Model
PRODUCT_MODEL := moto g(8) family

# Overlays
PRODUCT_PACKAGES += \
    amogusApertureOverlay \
    amogusFrameworksOverlay \
    amogusLineageSDKOverlay \
    amogusSettingsOverlay \
    ravFrameworksOverlay \
    ravSystemUIOverlay \
    sofiaFrameworksOverlay \
    sofiaSystemUIOverlay \
    sofiapFrameworksOverlay \
    sofiapSFrameworksOverlay \
    sofiapSSystemUIOverlay \
    sofiapSystemUIOverlay \
    sofiarFrameworksOverlay \
    sofiarSystemUIOverlay

# Charging Control
PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

# Regulatory
PRODUCT_PACKAGES += \
    XT2041-1RegulatoryOverlay \
    XT2041-3RegulatoryOverlay \
    XT2041-4RegulatoryOverlay \
    XT2041-5RegulatoryOverlay \
    XT2041-6RegulatoryOverlay \
    XT2041-7RegulatoryOverlay \
    XT2043-7RegulatoryOverlay \
    XT2043-8RegulatoryOverlay \
    XT2045-1RegulatoryOverlay \
    XT2045-2RegulatoryOverlay \
    XT2045-3RegulatoryOverlay \
    XT2045-6RegulatoryOverlay

# Platform
TRINKET := trinket
TARGET_BOARD_PLATFORM := $(TRINKET)
TARGET_KERNEL_VERSION := 4.14
PRODUCT_PLATFORM_MOT := true
PRODUCT_USES_QCOM_HARDWARE := true

# Power
PRODUCT_USES_PIXEL_POWER_HAL := true

# Props
PRODUCT_COPY_FILES += \
    $(PLATFORM_COMMON_PATH)/props/build_rav.prop:$(TARGET_COPY_OUT_VENDOR)/build_rav.prop \
    $(PLATFORM_COMMON_PATH)/props/build_sofia.prop:$(TARGET_COPY_OUT_VENDOR)/build_sofia.prop \
    $(PLATFORM_COMMON_PATH)/props/build_sofiap.prop:$(TARGET_COPY_OUT_VENDOR)/build_sofiap.prop \
    $(PLATFORM_COMMON_PATH)/props/build_sofiar.prop:$(TARGET_COPY_OUT_VENDOR)/build_sofiar.prop

TARGET_VENDOR_PROP += $(PLATFORM_COMMON_PATH)/props/vendor.prop

# QCOM Bluetooth
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.qcom.bluetooth.soc=cherokee

# Recovery
include $(PLATFORM_COMMON_PATH)/device-recovery.mk

# Telephony
PRODUCT_VENDOR_PROPERTIES += \
    ro.telephony.default_network=10,10

# ZRAM Writeback
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.zram_enabled=1

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.qti.config.zram=false \
    ro.zram.mark_idle_delay_mins=60 \
    ro.zram.first_wb_delay_mins=180 \
    ro.zram.periodic_wb_delay_hours=24

# Android 17 SurfaceFlinger & UI Tunables
PRODUCT_PRODUCT_PROPERTIES += \
    sys.use_fifo_ui=1

PRODUCT_VENDOR_PROPERTIES += \
    ro.surface_flinger.enable_layer_caching=true

# Audio effects (override QCOM trinket audio_effects.xml referencing missing offload_bundle)
PRODUCT_COPY_FILES += \
    device/motorola/common/rootdir/vendor/etc/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

# Inherit from those products. Most specific first.
$(call inherit-product, device/motorola/common/common.mk)

# Include board vendor blobs
$(call inherit-product-if-exists, vendor/motorola/amogus/amogus-vendor.mk)
