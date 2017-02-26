# Copyright (C) 2016-2017 AOTP - Android Open Tuning Project
# Copyright (C) 2016-2017 ElixiumOS
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
PRODUCT_COPY_FILES += \
    vendor/elixium/etc-permission/permissions/com.cyngn.audiofx.xml:system/etc/permissions \
    vendor/elixium/fonts/SST-UltraLight.ttf:system/fonts/SST-UltraLight.ttf \
    vendor/elixium/fonts/.SST-Condensed.ttf:system/fonts/.SST-Condensed.ttf \
    vendor/elixium/fonts/.SST-CondensedBd.ttf:system/fonts/.SST-CondensedBd.ttf \
    vendor/elixium/fonts/.SST-Heavy.ttf:system/fonts/.SST-Heavy.ttf \
    vendor/elixium/fonts/.SST-HeavyItalic.ttf:system/fonts/.SST-HeavyItalic.ttf \
    vendor/elixium/fonts/.SST-Light.ttf:system/fonts/.SST-Light.ttf \
    vendor/elixium/fonts/.SST-LightItalic.ttf:system/fonts/.SST-LightItalic.ttf \
    vendor/elixium/fonts/.SST-Medium.ttf:system/fonts/.SST-Medium.ttf \
    vendor/elixium/fonts/.SST-MediumItalic.ttf:system/fonts/.SST-MediumItalic.ttf \
    vendor/elixium/fonts/.SST-UltraLight.ttf:system/fonts/.SST-UltraLight.ttf \
    vendor/elixium/fonts/.SST-UltraLightItalic.ttf:system/fonts/.SST-UltraLightItalic.ttf \
    vendor/elixium/fonts/.SSTVietnamese-Bold.ttf:system/fonts/.SSTVietnamese-Bold.ttf \
    vendor/elixium/fonts/.SSTVietnamese-Roman.ttf:system/fonts/.SSTVietnamese-Roman.ttf


PRODUCT_BUILD_PROP_OVERRIDES := BUILD_DISPLAY_ID=$(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(BUILD_ID)
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_BUILD_TYPE=user

# Some overlays
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.com.android.dataroaming=false \
    drm.service.enabled=true \
    net.tethering.noprovisioning=true \
    persist.sys.dun.override=0 \
    ro.build.selinux=1 \
    ro.adb.secure=0 \
    ro.storage_manager.enabled=1

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

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/elixium/overlay/common

# Walpaper overlay
ifeq ($(filter true,$(TARGET_BOOTANIMATION_QHD)),)
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
    Chrome \
    GoogleCamera \
    Launcher \
    GoogleWallpaper \
    Busybox \
    LockClock \
    masquerade \
    Stk \
    LatinIME \
    Terminal \
    MagiskManager

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
#Bootanimation setted on 1000x1000
ifneq ($(BOOTANIMATION_1000P),true)
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-1000.zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-800.zip:system/media/bootanimation.zip
endif

