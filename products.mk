# Copyright (C) 2017 ElixiumOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#All the product copy files
#PRODUCT_COPY_FILES += \
#    vendor/elixium/fonts/SST-UltraLight.ttf:system/fonts/SST-UltraLight.ttf \
#    vendor/elixium/fonts/.SST-Condensed.ttf:system/fonts/.SST-Condensed.ttf \
#    vendor/elixium/fonts/.SST-CondensedBd.ttf:system/fonts/.SST-CondensedBd.ttf \
#    vendor/elixium/fonts/.SST-Heavy.ttf:system/fonts/.SST-Heavy.ttf \
#    vendor/elixium/fonts/.SST-HeavyItalic.ttf:system/fonts/.SST-HeavyItalic.ttf \
#    vendor/elixium/fonts/.SST-Light.ttf:system/fonts/.SST-Light.ttf \
#    vendor/elixium/fonts/.SST-LightItalic.ttf:system/fonts/.SST-LightItalic.ttf \
#    vendor/elixium/fonts/.SST-Medium.ttf:system/fonts/.SST-Medium.ttf \
#    vendor/elixium/fonts/.SST-MediumItalic.ttf:system/fonts/.SST-MediumItalic.ttf \
#    vendor/elixium/fonts/.SST-UltraLight.ttf:system/fonts/.SST-UltraLight.ttf \
#    vendor/elixium/fonts/.SST-UltraLightItalic.ttf:system/fonts/.SST-UltraLightItalic.ttf \
#   vendor/elixium/fonts/.SSTVietnamese-Bold.ttf:system/fonts/.SSTVietnamese-Bold.ttf \
#    vendor/elixium/fonts/.SSTVietnamese-Roman.ttf:system/fonts/.SSTVietnamese-Roman.ttf

# AudioFX permission
PRODUCT_COPY_FILES += \
    vendor/elixium/etc/permissions/com.cyngn.audiofx.xml:system/etc/permissions \

PRODUCT_BUILD_PROP_OVERRIDES := BUILD_DISPLAY_ID=$(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(BUILD_ID)
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_BUILD_TYPE=user

# Some overlays
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.setupwizard.rotation_locked=true \
    ro.build.selinux=0 \
    persist.sys.dun.override=0 \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so \
    ro.substratum.verified=true \
    ro.opa.eligible_device=true \
    persist.sys.recovery_update=false

# Needs for MTP Dirty Hack
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Disable HDCP check
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.wfd.nohdcp=1

ADDITIONAL_DEFAULT_PROPERTIES := \
    ro.adb.secure=0 \
    ro.secure=0 \
    persist.service.adb.enable=1

# Set cache location
ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.device.cache_dir=/data/cache
else
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.device.cache_dir=/cache
endif

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/elixium/overlay/common

# Walpaper overlay
ifeq ($(filter true,$(WALLPAPER_QHD)),)
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/elixium/overlay/wallpaper/wallpaper-qhd
else
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/elixium/overlay/wallpaper/wallpaper-fhd
endif

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Latin IME lib - gesture typing
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# Extra packages
PRODUCT_PACKAGES += \
    AudioFX \
    Busybox \
    BluetoothExt \
    MusicFX \
    LatinIME \
    libemoji \
    libsepol \
    Launcher3 \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    powertop \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    GoogleWallpaper \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    Snap \
    ThemeInterfacer \
    Terminal \
    AEXPapers \
    Turbo \
    MagiskManager \
    Substratum \
    Launcher3 \
    Terminal

# MusicFX advanced effects
ifneq ($(TARGET_NO_DSPMANAGER), true)
PRODUCT_PACKAGES += \
    libcyanogen-dsp \
    audio_effects.conf
endif

# Pixels additional packages
PRODUCT_PACKAGES += \
    UsTwoWalls \
    BReelWalls \
    NexusWallpapersStubPrebuilt
	
# Init.d script support
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/bin/sysinit:system/bin/sysinit \
    vendor/elixium/prebuilt/init.d/00banner:system/etc/init.d/00banner \
    vendor/elixium/prebuilt/init.d/init.d.rc:root/init.d.rc

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/addon.d/50-elixium.sh:system/addon.d/50-elixium.sh \
    vendor/elixium/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/elixium/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions

# Magisk
PRODUCT_COPY_FILES += \
   vendor/elixium/prebuilt/magisk/magisk.zip:system/addon.d/magisk.zip

# Bootanimations
ifneq ($(BOOTANIMATION_1000P),true)
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-1000.zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-800.zip:system/media/bootanimation.zip
endif

# LCD Overlay
ifneq ($(filter oneplus3 griffin,$(PRODUCT_DEVICE)),)
PRODUCT_PROPERTY_OVERRIDES += ro.sf.lcd_density=460
endif

