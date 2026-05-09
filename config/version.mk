CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

AOSP_BUILD_TYPE ?= COMMUNITY-BUILD

AOSP_VERSION := AndroidOne-$(CURRENT_DEVICE)-OTA-$(shell date -u +%Y%m%d-%H%M)

# Default updater branch version
AOSP_BUILD_VERSION := 16

# Private build uses separate OTA branch
ifeq ($(AOSP_BUILD_TYPE),PRIVATE-BUILD)
AOSP_BUILD_VERSION := 16-private
endif

# AOSP version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.aosp.version=$(AOSP_VERSION) \
    ro.aosp.releasetype=$(AOSP_BUILD_TYPE) \
    ro.aosp.build.version=$(AOSP_BUILD_VERSION)

# Updater for production + private builds
ifneq ($(filter $(AOSP_BUILD_TYPE),PRODUCTION-BUILD PRIVATE-BUILD),)

PRODUCT_PACKAGES += Updater
PRODUCT_PACKAGE_OVERLAYS += vendor/aosp/overlay/Updater

endif