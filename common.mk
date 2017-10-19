PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
ELIXIUM_BUILD += true

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/elixium/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/elixium/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# discovery-specific init file
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/etc/init.local.rc:root/init.discovery.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/elixium/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/elixium/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# discovery-specific startup services
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/elixium/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/elixium/prebuilt/common/bin/sysinit:system/bin/sysinit

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    LockClock \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    LatinIME \
    BluetoothExt

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Extra ElixiumOS packages
PRODUCT_PACKAGES += \
    GoogleWallPicker \
		Turbo \
		GClock \
		OPGallery

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

# Charger
ifneq ($(WITH_CM_CHARGER),false)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.cm
endif

# SIM Toolkit
PRODUCT_PACKAGES += \
    Stk

# SMS
PRODUCT_PACKAGES += \
		messaging

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

PRODUCT_PACKAGE_OVERLAYS += vendor/elixium/overlay/common

# World APN list
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# This device supports CM enhanced NFC
PRODUCT_COPY_FILES += \
    vendor/elixium/config/permissions/com.cyanogenmod.nfc.enhanced.xml:system/etc/permissions/com.cyanogenmod.nfc.enhanced.xml

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/elixium/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
  	vendor/elixium/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
	  vendor/elixium/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/elixium/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif

# Google Camera with HDR+ enabled for Snapdragon 820/821 and 835 devices
ifneq ($(TARGET_BOARD_PLATFORM),msm8996,msm8998)
PRODUCT_PACKAGES += GCam
endif

# Bootanimations
ifneq ($(BOOTANIMATION_1000P),true)
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-1000.zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-800.zip:system/media/bootanimation.zip
endif

# Google sounds
include vendor/elixium/google/GoogleAudio.mk

# Jack server heap size
export ANDROID_JACK_VM_ARGS += "-Xmx4096m"

EXTENDED_POST_PROCESS_PROPS := vendor/elixium/tools/discovery_process_props.py
