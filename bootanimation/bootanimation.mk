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

#Bootanimation setted on 1000x1000
ifneq ($(filter x1000,$(BOOTANIMATION_RESOLUTION)),)
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-1000.zip:system/media/bootanimation.zip
endif

#Bootanimation setted on 800x800
ifneq ($(filter x800,$(BOOTANIMATION_RESOLUTION)),)
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-800.zip:system/media/bootanimation.zip
endif

#Bootanimation setted on 600x600
ifneq ($(filter x600,$(BOOTANIMATION_RESOLUTION)),)
PRODUCT_COPY_FILES += \
    vendor/elixium/bootanimation/bootanimation-600.zip:system/media/bootanimation.zip
endif
