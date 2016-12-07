# Copyright (C) 2016-2017 AOTP - Android Open Tuning Project
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

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

ifneq ($(filter arm64,$(TARGET_ARCH)),)
LOCAL_SRC_FILES := Camera-arm64.apk
else
LOCAL_SRC_FILES := Camera-arm.apk
endif

LOCAL_MODULE := GoogleCamera

LOCAL_JACK_ENABLED := disabled

LOCAL_CERTIFICATE := platform

LOCAL_MODULE_CLASS := APPS

LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)

include $(BUILD_PREBUILT)


